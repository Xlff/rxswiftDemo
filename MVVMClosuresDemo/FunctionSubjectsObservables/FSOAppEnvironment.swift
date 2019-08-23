//
//  FSOAppEnvironment.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/21.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation

final class FSOAppEnvironment {
    static var current = Environment()
}

struct Environment {
    let networkingService: FSONetworkingService
    init(networkingService: FSONetworkingService = FSONetworkingAPI()) {
        self.networkingService = networkingService
    }
}
