//
//  urls.swift
//  Client
//
//  Created by GS on 2023/2/16.
//

import Foundation

class urls {
    static var ip = "192.168.11.10"
    static var port = "8883"
    static var register_url: String = "http://" + ip + ":" + port + "/register"
    static var login_url: String = "http://" + ip + ":" + port + "/login"
    static var logout_url: String = "http://" + ip + ":" + port + "/logout"
    static var addbook_url: String = "http://" + ip + ":" + port + "/addbooks"
    static var deletebook_url: String = "http://" + ip + ":" + port + "/deletebooks"
    static var borrowbook_url: String = "http://" + ip + ":" + port + "/borrowbooks"
    static var returnbook_url: String = "http://" + ip + ":" + port + "/returnbooks"
    static var showbooks_url: String = "http://" + ip + ":" + port + "/getbooklist"
    static var test_url: String = "https://httpbin.org/post"
    init() {}
}
