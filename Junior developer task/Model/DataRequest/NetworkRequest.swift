//
//  NetworkRequest.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-09.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case noDataAvailable
    case noUrlAvailable
    case cannotProcessData
}

class NetworkRequest {
    
    func getToken(url: URL?, username: String, password: String, completion: @escaping (Result<String, RequestError>) -> ()) {
        
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
                    completion(.success(token))
                }
            }
        }
    }
    
    func getServersList(withToken: String, url: URL?, completion: @escaping (Result<[ServerList], RequestError>) -> ()) {
        
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
                do {
                    let decoder = JSONDecoder()
                    let list = try decoder.decode([ServerList].self, from: data)
                    completion(.success(list))
                } catch {
                    completion(.failure(.cannotProcessData))
                }
            }
        }
    }
    
    private func getDataFor(request: URLRequest, completion: @escaping (Result<Data, RequestError>) -> ()) {
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
