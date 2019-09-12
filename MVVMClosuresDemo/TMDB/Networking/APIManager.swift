//
//  HTTPClient.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/23.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Moya

enum APIManager {
    case login(String, String, String)
    case auth
    
    case popularMovies
    case movieDetail(Int)
    case searchMovies(String)
    
    case popularPeople
    case searchPeople(String)
    
    case popularShows
}


extension APIManager: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3?api_key=\(Constants.apiKey)")!
    }
    
    var path: String {
        switch self {
        case .login(_, _, _):
            return "/authentication/token/validate_with_login"
        case .auth:
            return "/authentication/token/new"
        case .popularMovies:
            return "/discover/movie"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .searchMovies(_):
            return "/search/movie"
            
        case .popularPeople:
            return "/person/popular"
            
        case .popularShows:
            return "/discover/tv"
        case .searchPeople(_):
            return "/search/person"
        }
    }
    
    var method: Method {
        switch self {
        case .login(_, _, _):
            return .post
        default:        
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var parameters: [String: Any] {
        var params = [String: Any]()
        
        switch self {
        case .login(let username, let password, let token):
            params["username"] = username
            params["password"] = password
            params["request_token"] = token

        case .popularMovies:
            return ["language": "en-US",
                    "sort_by": "popularity.desc",
                    "include_adult": false,
                    "include_video": false]
            
        case .movieDetail(_):
            return ["language": "en-US"]
        case .searchMovies(let query):
            params["query"] = query
            params["page"] = 1
        case .popularPeople:
            params["page"] = 2
        case .popularShows:
            return ["language": "en-US",
                    "page": "1",
                    "include_null_first_air_dates": false,
                    "sort_by": "popularity.desc"]
        case .searchPeople(let query):
            return ["language": "en-US",
                    "page": "1",
                    "include": false,
                    "query": query]
        default:
            return params
        }
        return params
    }
    
    var task: Task {
        switch self {
        case .auth:
            return .requestPlain
            
        case .login(_, _, _):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        default:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
         return ["Content-type": "application/json"]
    }
    
    
}
