//
//  APIResponses.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/23.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation

struct LoginResponse: Decodable {
    let success: Bool
}

struct AuthTokenResponse: Decodable {
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}
