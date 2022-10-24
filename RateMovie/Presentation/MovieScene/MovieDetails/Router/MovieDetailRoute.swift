//
//  MovieDetailRoute.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 18/10/22.
//

import Foundation
import Router
import UIKit

protocol MovieDetailRoute {
    func toDetailMovie(with movieId: Int, data: FavoriteNowPlaying)
}

extension MovieDetailRoute where Self: Router {
    func toDetailMovie(with transition: Transition, movieId: Int, data: FavoriteNowPlaying) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = MovieDetailsViewController()
        let vm = DefaultMovieDetailsViewModel(movieId: movieId)
        vc.viewModel = vm
        vc.movieResult = data
        vc.hidesBottomBarWhenPushed = true
//        router.root = vc
        print("============adsfas")
        route(to: vc, as: transition)
    }
    
    func toDetailMovie(with movieId: Int, data: FavoriteNowPlaying) {
        toDetailMovie(with: PushTransition(), movieId: movieId, data: data)
    }
}

extension DefaultRouter: MovieDetailRoute { }
