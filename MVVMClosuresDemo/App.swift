//
//  APP.swift
//  MVVMClosuresDemo
//
//  Created by Max xie on 2019/8/29.
//  Copyright © 2019 w!zzard. All rights reserved.
//

import UIKit

final class App {
    static let shared = App()
    
    func startInterface(in window: UIWindow) {
        let discoverNavigationController = UINavigationController()
        let discoverNavigator = DiscoverNavigator(navigationController: discoverNavigationController)
        let discoverVM = DiscoverViewModel(dependecies: DiscoverViewModel.Dependencies(api: API(), navigator: discoverNavigator))
        let discoverVC = UIStoryboard.main.discoverViewController
        discoverVC.viewModel = discoverVM
        
        let searchNavigationController = UINavigationController()
        let searchNavigator = SearchMovieNavigator(navigationController: searchNavigationController)
        let searchViewModel = SearchViewModel(dependencies: SearchViewModel.Dependencies(api: API(), navigator: searchNavigator))
        let searchViewController = UIStoryboard.main.searchViewController
        searchViewController.viewModel = searchViewModel
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0)
        tabBarController.tabBar.tintColor = .white
        
        discoverNavigationController.tabBarItem = UITabBarItem(title: "Discover", image: nil, selectedImage: nil)
        discoverNavigationController.viewControllers = [discoverVC]
        
        searchNavigationController.viewControllers = [searchViewController]
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        
        tabBarController.viewControllers = [
            discoverNavigationController,
            searchNavigationController
        ]
        
        let loginNavigationController = UINavigationController()
        let loginNavigator = LoginNavigator(nav: loginNavigationController)
        let loginViewModel = LoginViewModel(dependencies: LoginViewModel.Dependencies(api: API(), navigator: loginNavigator))
        let loginViewController = UIStoryboard.main.loginViewController
        loginViewController.viewModel = loginViewModel
        loginNavigationController.viewControllers = [loginViewController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        tabBarController.present(loginNavigationController, animated: true, completion: nil)
        
    }
}
