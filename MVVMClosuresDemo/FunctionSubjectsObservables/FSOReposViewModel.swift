//
//  FSOReposViewModel.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/21.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FSORepoViewModelInputs {
    func viewWillAppear()
    func didSelect(index: IndexPath)
    func didSearch(query: String)
}

protocol FSORepoViewModelOutputs {
    var loading: Driver<Bool> { get }
    var repos: Driver<[RepoViewModel]> { get }
    var selectedRepoId: Driver<Int> { get }
}

protocol FSOReposViewModelType {
    var inputs: FSORepoViewModelInputs { get }
    var outputs: FSORepoViewModelOutputs { get }
}


final class FSOReposViewModel: FSOReposViewModelType, FSORepoViewModelInputs, FSORepoViewModelOutputs {
    init() {
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let initialRepos = self.viewWillAppearSubject
            .asObserver()
            .flatMap { _ in
                FSOAppEnvironment.current.networkingService
                    .searchRepos(withQuery: "swift")
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: [])
        
        let searchRepos = self.didSearchSubject
            .asObserver()
            .filter { $0.count > 2 }
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query in
                FSOAppEnvironment.current.networkingService
                    .searchRepos(withQuery: query)
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: [])
        
        let repos = Driver.merge(initialRepos, searchRepos)
        self.repos = repos.map { $0.map { RepoViewModel(repo: $0) } }
        self.selectedRepoId = self.didSelectSubject
            .asObserver()
            .withLatestFrom(repos) { indexPath, repos in
                return repos[indexPath.item]
            }
            .map { $0.id }
            .asDriver(onErrorJustReturn: 0)
    }
    
    
    private let viewWillAppearSubject = PublishSubject<Void>()
    func viewWillAppear() {
        viewWillAppearSubject.onNext(())
    }

    private let didSelectSubject = PublishSubject<IndexPath>()
    func didSelect(index: IndexPath) {
        didSelectSubject.onNext(index)
    }

    private let didSearchSubject = PublishSubject<String>()
    func didSearch(query: String) {
        didSearchSubject.onNext(query)
    }

    let loading: Driver<Bool>
    let repos: Driver<[RepoViewModel]>
    let selectedRepoId: Driver<Int>
    
    var inputs: FSORepoViewModelInputs { return self }
    var outputs: FSORepoViewModelOutputs { return self }

}
