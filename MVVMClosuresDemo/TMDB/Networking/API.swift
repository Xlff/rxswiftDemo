//
//  API.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/23.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

struct Constants {
    static let apiKey = "e37e45413588184ff74b7e315cbcd6a5"
}

final class APIKeyPlugs: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
    }
}

protocol ApiAuthProvider {
    func login(withUsername username: String, password: String) -> Observable<Bool>
}

protocol ApiMoviesProvider {
    func fetchPopularMovies() -> Observable<[Movie]?>
    func fetchMovieDetails(forMovieId id: Int) -> Observable<Movie>
    func searchMovies(forQuery query: String) -> Observable<[Movie]?>
}

protocol ApiPeopleProvider {
    func fetchPopularPeople() -> Observable<[Person]?>
    func searchPeople(forQuery query: String) -> Observable<[Person]?>
}

protocol ApiShowsProvider {
    func fetchPopularShow() -> Observable<[Show]?>
}

protocol ApiProvider: ApiAuthProvider, ApiMoviesProvider, ApiPeopleProvider, ApiShowsProvider { }

final class API: ApiProvider {
    private var provider = MoyaProvider<APIManager>(plugins: [APIKeyPlugs(), NetworkLoggerPlugin()])
    //MARK: Login
    func login(withUsername username: String, password: String) -> Observable<Bool> {
        return fetchAutToken()
            .flatMap{ [weak self] (token : String)  -> Observable<Bool> in
                guard let strongSelf = self else {
                    return Observable.just(false)
                }
                return strongSelf.provider.rx
                    .request(.login(username, password, token))
                    .map(LoginResponse.self)
                    .asObservable()
                    .map { return $0.success }
        }
    }
    
    private func fetchAutToken() -> Observable<String> {
         return provider.rx.request(.auth)
            .filterSuccessfulStatusCodes()
            .map(AuthTokenResponse.self)
            .asObservable()
            .map { $0.requestToken }
    }
    
    //MARK: Discover
    
    func fetchPopularMovies() -> Observable<[Movie]?> {
        return provider.rx.request(.popularMovies)
            .map(MovieResponse.self)
            .map{ $0.results }
            .asObservable()
            .catchErrorJustReturn(nil)
    }
    
    func fetchMovieDetails(forMovieId id: Int) -> Observable<Movie> {
        return provider.rx.request(.movieDetail(id))
            .map(Movie.self)
            .asObservable()
    }
    
    func searchMovies(forQuery query: String) -> Observable<[Movie]?> {
        return provider.rx.request(.searchMovies(query))
            .map(MovieResponse.self)
            .map { $0.results }
            .asObservable()
            .catchErrorJustReturn(nil)
    }
    
    //MARK: People
    func fetchPopularPeople() -> Observable<[Person]?> {
        return provider.rx.request(.popularPeople)
            .map(PeopleResponse.self)
            .map { $0.results }
            .asObservable()
    }
    
    func searchPeople(forQuery query: String) -> Observable<[Person]?> {
        return provider.rx.request(.searchPeople(query))
            .map(PeopleResponse.self)
            .map { $0.results }
            .asObservable()
    }
    
    func fetchPopularShow() -> Observable<[Show]?> {
        return provider.rx.request(.popularShows)
        .map(ShowsResponse.self)
            .map { $0.results }
        .asObservable()
    }
}
