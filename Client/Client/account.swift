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
    static var authtype: Int = 1
    static var sessionkey: String = "sessionkey"
    init() {}
    static func set(username: String, email: String, password: String, authtype: Int, sessionkey: String) {
        self.username = username
        self.email = email
        self.password = password
        self.authtype = authtype
        self.sessionkey = sessionkey
    }

    static func reset() {
        username = "username"
        email = "email"
        password = "password"
        authtype = 1
        sessionkey = "sessionkey"
    }
}
