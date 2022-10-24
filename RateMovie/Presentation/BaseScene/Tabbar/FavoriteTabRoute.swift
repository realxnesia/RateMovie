//
//  FavoriteTabROute.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 18/10/22.
//

import Foundation
import UIKit
import Router

protocol FavoriteTabRoute {
    func makeFavoriteTab() -> UIViewController
}

extension FavoriteTabRoute where Self: Router {
    func makeFavoriteTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = MovieFavouritesViewController()
        let vm = DefaultMovieFavouritesViewModel()
        vc.navigationItem.backButtonTitle = ""
//        vc.viewModel = vm
        router.root = vc
        
//        let navigation = UINavigationController(rootViewController: vc)
        let navigation = RootViewController(rootViewController: vc)
        let navBarAppearance = UINavigationBarAppearance()
        return navigation
    }
    
}

extension DefaultRouter: FavoriteTabRoute {}
