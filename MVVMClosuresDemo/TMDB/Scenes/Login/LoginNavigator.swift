//
//  LoginNavigator.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/23.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

protocol LoginNavigatable {
    func toMain()
}

final class LoginNavigator {
    private let navigationController: UINavigationController
    init(nav: UINavigationController) {
        navigationController = nav
    }
    
    func toMain() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
