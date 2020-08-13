//
//  Networking.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-11.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import Foundation
import PromiseKit

protocol NetworkingProtocol {
    func promiseLogin(url: URL?, username: String, password: String) -> Promise<String>
    func getToken() -> String
    func promiseGetServerList(withToken: String, url: URL?) -> Promise<String>
}
