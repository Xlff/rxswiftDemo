//
//  HTTPClient.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/23.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Moya

enum APIManager {
    case login(String, String)
    case auth
}

extension APIManager: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/?api_key=\(Constants.apiKey)")!
    }
    
    var path: String {
        switch self {
        case .login(_, _):
            return "authentication/token/validate_with_login"
        case .auth:
            return "https://api.themoviedb.org/3/authentication/token/new"
        default:
            return ""
        }
    }
    
    var method: Method {
        switch self {
        case .login(_, _):
            return .post
        default:        
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var parameters: [String: Any] {
        
        switch self {
        case .login(let username, let password):
            return ["username": username,
                    "password": password,
                    ]
            
        default:
            return [:]
        }
    }
    
    var task: Task {
        switch self {
        case .login(_, _):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
         return ["Content-type": "application/json"]
    }
    
    
}
