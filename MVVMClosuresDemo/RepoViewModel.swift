//
//  RepoViewModel.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/22.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation

struct RepoViewModel {
    let name: String
}

extension RepoViewModel {
    init(repo: Repo) {
        self.name = repo.name
    }
}
