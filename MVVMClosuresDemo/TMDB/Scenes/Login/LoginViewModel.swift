//
//  LoginViewModel.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/23.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum LoginResult {
    case success
    case failure
}


final class LoginViewModel: ViewModelType {

    struct Input {
        let username: Driver<String>
        let password: Driver<String>
        let loginTap: Signal<Void>
    }
    
    struct Output {
        let enabled: Driver<Bool>
        let loading: Driver<Bool>
        let result: Driver<LoginResult>
    }
    
    struct Dependencies {
        let api: API
        let navigator: LoginNavigator
    }
    
    private let dependencies : Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        let isUsernameValid = input.username.map { $0.count > 0 }
        let isPasswordValid = input.password.map { $0.count > 3 }
        let enable = Driver.combineLatest(isUsernameValid, isPasswordValid) { $0 && $1 }
        
        let loadingIndicator = ActivityIndicator()
        let loading = loadingIndicator.asDriver()
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) { ($0, $1) }
            .asObservable()
        
        let result = input.loginTap
            .asObservable()
            .withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair -> Observable<Bool> in
                let (username, password) = pair
                return self.dependencies.api.login(withUsername: username, password: password)
                    .trackActivity(loadingIndicator)
        }
            .map { $0 ? LoginResult.success : LoginResult.failure }
            .asDriver(onErrorJustReturn: .failure)
            .do(onNext: { [weak self] loginResult in
                guard loginResult == .success , let strongSelf = self else { return }
                strongSelf.dependencies.navigator.toMain()
            })
        
        return Output(enabled: enable,
                      loading: loading,
                      result: result)
    }
    
    
    
}
