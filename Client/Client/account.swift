//
//  account.swift
//  Client
//
//  Created by GS on 2023/2/15.
//

import Foundation

class account {
    static var username: String = "username"
    static var email: String = "email"
    static var password: String = "password"
    init() {}
    static func set(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}
