//
//  UIStoryboard+ViewControllers.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/23.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}


extension UIStoryboard {
    var loginViewController: LoginViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            fatalError("LoginViewController couldn't be found in Storyboard file")
        }
        return vc
    }
}
