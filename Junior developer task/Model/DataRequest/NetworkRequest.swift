//
//  NetworkRequest.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-09.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import Foundation
import PromiseKit

enum RequestError: Error {
    case noDataAvailable
    case noUrlAvailable
    case cannotProcessData
}

class NetworkRequest: NetworkingProtocol {
    
    private var receivedToken = ""
    
    func promiseLogin(url: URL?, username: String, password: String) -> Promise<String> {
        return Promise { r in
            logIn(url: url, username: username, password: password) { (result) in
                switch result {
                case .success(_):
                    r.fulfill("Token request successful")
                case .failure(let error):
                    r.reject(error)
                }
            }
        }
    }
    
    func promiseGetServerList(withToken: String, url: URL?) -> Promise<String> {
        return Promise { r in
            getServersList(withToken: withToken, url: url) { (result) in
                switch result {
                case .success(let serverList):
                    r.fulfill(serverList)
                case .failure(let error):
                    r.reject(error)
                }
            }
        }
    }
    
    func getToken() -> String {
        return receivedToken
    }
    
    private func logIn(url: URL?, username: String, password: String, completion: @escaping (Swift.Result<String, RequestError>) -> ()) {
        
        guard let url = url else {
            completion(.failure(.noUrlAvailable))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: String] = ["username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        
        getDataFor(request: request) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: String] {
                    guard let token = responseJSON["token"] else {
                        completion(.failure(.cannotProcessData))
                        return
                    }
                    self.receivedToken = String(token)
                    completion(.success(""))
                }
            }
        }
    }
    
    private func getServersList(withToken: String, url: URL?, completion: @escaping (Swift.Result<String, RequestError>) -> ()) {
        
         guard let url = url else {
            completion(.failure(.noUrlAvailable))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(withToken)", forHTTPHeaderField: "Authorization")

        getDataFor(request: request) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(String(data: data, encoding: .utf8) ?? ""))
            }
        }
    }
    
    private func getDataFor(request: URLRequest, completion: @escaping (Swift.Result<Data, RequestError>) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { (data, _ , _) in
                 guard let data = data else {
                     completion(.failure(.noDataAvailable))
                     return
                 }
            completion(.success(data))
        }
        task.resume()
    }
}
