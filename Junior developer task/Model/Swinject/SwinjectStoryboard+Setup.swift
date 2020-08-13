//
//  SwinjectStoryboard+Setup.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-11.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { r, c in
            c.networkRequest = r.resolve(NetworkingProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(ServerListViewController.self) { r, c in
            c.networkRequest = r.resolve(NetworkingProtocol.self)
        }
        defaultContainer.register(NetworkingProtocol.self) { _ in NetworkRequest() }.inObjectScope(.container)
    }
}
