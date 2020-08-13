//
//  Networking.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-11.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import Foundation

protocol NetworkingProtocol {
    func logIn(url: URL?, username: String, password: String, completion: @escaping (Result<String, RequestError>) -> ())
    func getToken() -> String
    func getServersList(withToken: String, url: URL?, completion: @escaping (Result<[ServerList], RequestError>) -> ())
}
