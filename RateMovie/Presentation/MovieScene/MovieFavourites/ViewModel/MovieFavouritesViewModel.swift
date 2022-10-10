//
//  MovieFavouritesViewModel.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import Foundation

protocol MovieFavouritesViewModelInput {
    func getListFavorite()
    func deleteFavorite(with id: Int)
}

protocol MovieFavouritesViewModelOutput {
    var errorMessage: Observable<String> { get }
    var movieFavouriteList: Observable<[MoviesFavouritesModel]> { get }
}

protocol MovieFavouritesViewModel: MovieFavouritesViewModelInput, MovieFavouritesViewModelOutput { }

final class DefaultMovieFavouritesViewModel: MovieFavouritesViewModel {
    let errorMessage: Observable<String> = Observable("")
    let movieFavouriteList: Observable<[MoviesFavouritesModel]> = Observable([])
    
    private let useCaseFavorite = DefaultMovieFavoritesUseCase()
    
    init() {
        getListFavorite()
    }
    
}

extension DefaultMovieFavouritesViewModel {
    func getListFavorite() {
        useCaseFavorite.getListFavorite { [weak self] data in
            self?.movieFavouriteList.value = data
        }
    }
    
    func deleteFavorite(with id: Int) {
        useCaseFavorite.deleteFavorite(with: id)
    }
}
