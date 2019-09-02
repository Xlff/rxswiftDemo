//
//  SearchMovieNavigator.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/29.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit


protocol SearchMovieNavigatable {
    func navigateToMovieDetailScreen(withId id: Int, api: ApiProvider)
}

final class SearchMovieNavigator: SearchMovieNavigatable {
    
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToMovieDetailScreen(withId id: Int, api: ApiProvider) {
        let detailNavigator = DetailNavigator(navigationController: navigationController)
        let movieViewModel = DetailViewModel(dependencies: DetailViewModel.Dependencies(id: id,
                                                                        api: api,
                                                                        navigator: detailNavigator))
        let movieDetailVC = UIStoryboard.main.movieDetailViewController
        movieDetailVC.viewModel = movieViewModel
        navigationController.show(movieDetailVC, sender: nil)
    }
}
