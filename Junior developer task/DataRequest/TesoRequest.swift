//
//  TesoRequest.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-09.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case noTokenDataAvailable
    case noServerDataAvailable
    case cannotProcessData
}

class TesoRequest {
    func getToken(username: String, password: String, completion: @escaping (Result<String, RequestError>) -> ()) {
        
        let url = URL(string: "https://playground.tesonet.lt/v1/tokens")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: String] = ["username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(.failure(.noTokenDataAvailable))
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: String] {
                guard let token = responseJSON["token"] else {
                    completion(.failure(.cannotProcessData))
                    return
                }
                completion(.success(token))
            }
        }
        task.resume()
    }
    
    func getServersList(withToken: String, completion: @escaping (Result<[ServerList], RequestError>) -> ()) {
        
        guard let url = URL(string: "https://playground.tesonet.lt/v1/servers") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(withToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, _ , _) in
            guard let data = data else {
                completion(.failure(.noServerDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let list = try decoder.decode([ServerList].self, from: data)
                completion(.success(list))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        task.resume()
    }
}
