//
//  DiscoverNavigator.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/29.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

protocol DiscoverNavigatable {
    func navigateToMovieDetialScreen(withMovieId id: Int, api: ApiProvider)
    func navigateToPersonDetailScreen()
    func navigateToShowDetailScreen()
}

final class DiscoverNavigator: DiscoverNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToMovieDetialScreen(withMovieId id: Int, api: ApiProvider) {
        let detailNavigator = DetailNavigator(navigationController: navigationController)
        let movieDetailVM = DetailViewModel(dependencies: DetailViewModel.Dependencies(id: id,
                                                                                       api: api,
                                                                                       navigator: detailNavigator))
        let detailVC = UIStoryboard.main.movieDetailViewController
        detailVC.viewModel = movieDetailVM
        navigationController.show(detailVC, sender: nil)
    }
    
    func navigateToPersonDetailScreen() {
        print("not implemented")
    }
    
    func navigateToShowDetailScreen() {
        print("not implemented")
    }
}

