//
//  API.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/23.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

struct Constants {
    static let apiKey = "e37e45413588184ff74b7e315cbcd6a5"
}

final class APIKeyPlugs: PluginType {

}

protocol ApiAuthProvider {
    func login(withUsername username: String, password: String) -> Observable<Bool>
}

protocol ApiProvider: ApiAuthProvider { }

final class API: ApiProvider {
    private var provider = MoyaProvider<APIManager>(plugins: [APIKeyPlugs(), NetworkLoggerPlugin()])

    func login(withUsername username: String, password: String) -> Observable<Bool> {
        return fetchAutToken()
            .flatMap{ [weak self] (token : String)  -> Observable<Bool> in
                guard let strongSelf = self else {
                    return Observable.just(false)
                }
                return strongSelf.provider.rx
                    .request(.login(username, password, token))
                    .map(LoginResponse.self)
                    .asObservable()
                    .map { return $0.success }
        }
    }
    
    private func fetchAutToken() -> Observable<String> {
         return provider.rx.request(.auth)
            .filterSuccessfulStatusCodes()
            .map(AuthTokenResponse.self)
            .asObservable()
            .map { $0.requestToken }
    }
}
