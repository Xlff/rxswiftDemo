//
//  DetailViewModel.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/9/2.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import RxCocoa
import RxSwift

final class DetailViewModel: ViewModelType {
    
    struct Input {
        let ready: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let data: Driver<MovieDetailData?>
        let back: Driver<Void>
    }
    
    struct Dependencies {
        let id: Int
        let api: ApiProvider
        let navigator: DetailNavigator
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: DetailViewModel.Input) -> DetailViewModel.Output {
        let data = input.ready
            .asObservable()
            .flatMap { _ in
                self.dependencies.api.fetchMovieDetails(forMovieId: self.dependencies.id)
            }
            .map { return MovieDetailData(movie: $0) }
            .asDriver(onErrorJustReturn: nil)
        
        let back = input.backTrigger
            .do(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.dependencies.navigator.goBack()
            })
        
        return Output(data: data,
                      back: back)
    }
    
}



struct MovieDetailData {
    let title: String
    let releaseDate: String
    let overview: String
    let genres: String
    let runtime: String
    let voteAverage: String
    let posterUrl: String?
    let voteCount: String
    let status: String
}

extension MovieDetailData {
    init(movie: Movie) {
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.genres = movie.genres
            .flatMap {
                $0.map { $0.name }
                    .prefix(2)
                    .joined(separator: ", ")
            } ?? ""
        self.runtime = movie.runtime
            .flatMap { "\($0 / 60)hr \($0 % 60)min" } ?? ""
        self.voteAverage = movie.voteAverage
            .flatMap { String($0) } ?? ""
        self.posterUrl = movie.posterUrl.flatMap { "http://image.tmdb.org/t/p/w780/" + $0 }
        self.voteCount = movie.voteCount
            .flatMap { String($0) } ?? ""
        self.status = movie.status ?? ""
    }
}
