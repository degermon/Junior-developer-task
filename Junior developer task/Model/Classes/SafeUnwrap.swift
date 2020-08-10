//
//  SafeUnwrap.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-09.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import Foundation

class SafeUnwrap {
    static let shared = SafeUnwrap()
    
    func safeUnwrapOfString(string: String?) -> String {
        guard let safelyUnwrapped = string else {
            return ""
        }
        return safelyUnwrapped
    }
    
    func safeUnwrapOfInt(number: Int?) -> String { // and transform to String
        guard let safelyUnwrapped = number else {
            return ""
        }
        return String(safelyUnwrapped)
    }
}
