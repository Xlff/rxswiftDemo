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
        let enable: Driver<Bool>
        let loading: Driver<Bool>
        let result: Driver<LoginResult>
    }
    
    struct Dependencies {
        let api: API
        let navigator: LoginNavigator
    }
    
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        let isUsernameValid = input.username.map { $0.count > 0}
    }
    
    
    
}
