//
//  FSOViewModelType.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/21.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
