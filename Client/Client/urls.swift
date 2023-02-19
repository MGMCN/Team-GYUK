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
    static var test_url: String = "https://httpbin.org/post"
    init() {}
}
