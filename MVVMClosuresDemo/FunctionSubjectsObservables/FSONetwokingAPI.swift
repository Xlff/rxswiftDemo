//
//  FSONetwokingAPI.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/21.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FSONetworkingService {
    func searchRepos(withQuery query: String) -> Observable<[Repo]>
}

final class FSONetworkingAPI: FSONetworkingService {
    func searchRepos(withQuery query: String) -> Observable<[Repo]> {
        let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=\(query)")!)
        return URLSession.shared.rx.data(request: request)
            .map { data -> [Repo] in
                guard let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else { return [] }
                return response.items
        }
    }
}
