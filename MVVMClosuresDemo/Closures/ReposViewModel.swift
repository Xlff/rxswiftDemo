//
//  ReposViewModel.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/21.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation

final class ReposViewModel {
    // 输出
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateRepos: (([RepoViewModel]) -> Void)?
    var didSelectedRepo: ((Int) -> Void)?
    
    private(set) var repos: [Repo] = [Repo]() {
        didSet {
            didUpdateRepos?(repos.map { RepoViewModel(repo: $0) })
        }
    }
    
    private let throttle = Throttle(minimumDelay: 0.3)
    private var currentSearchNetworkTask: URLSessionDataTask?
    private var listQuery: String?
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    // 输入
    func ready() {
        isRefreshing?(true)
        networkingService.searchRepos(withQuery: "swift") { [weak self] repos in
            guard let strongSelf = self else { return }
            strongSelf.finishSearching(with: repos)
        }
    }
    
    func didChangeQuery(_ query: String) {
        guard query.count > 2, query != listQuery else { return }
        listQuery = query
        throttle.throttle {
            self.startSearchWithQuery(query)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
    }
    
    private func startSearchWithQuery(_ query: String) {
        currentSearchNetworkTask?.cancel()
        
        isRefreshing?(false)
        
        currentSearchNetworkTask = networkingService.searchRepos(withQuery: query) { [weak self] repos in
            guard let strongSelf = self else { return }
            strongSelf.finishSearching(with: repos)
        }
    }
    
    private func finishSearching(with repos: [Repo]) {
        isRefreshing?(false)
        self.repos = repos
    }
}


