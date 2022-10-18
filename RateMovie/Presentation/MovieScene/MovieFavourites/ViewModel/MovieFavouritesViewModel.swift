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
//    func getMovieSelectedFavorite(with movieId: Int)
}

protocol MovieFavouritesViewModelOutput {
    var errorMessage: Observable<String> { get }
    var movieFavouriteList: Observable<[MoviesFavouritesModel]> { get }
}

protocol MovieFavouritesViewModel: MovieFavouritesViewModelInput, MovieFavouritesViewModelOutput { }

final class DefaultMovieFavouritesViewModel: MovieFavouritesViewModel {
//    func getMovieSelectedFavorite(with movieId: Int) {
//        useCaseFavorite.getMovieSelectedFavorite(with: movieId, <#T##completion: (Bool) -> Void##(Bool) -> Void#>)
//    }
    
    let errorMessage: Observable<String> = Observable("")
    let movieFavouriteList: Observable<[MoviesFavouritesModel]> = Observable([])
    
    private let useCaseFavorite = DefaultMovieFavoritesUseCase()
    
    init() {
//        getListFavorite()
    }
    
}

extension DefaultMovieFavouritesViewModel {
    func getListFavorite() {
        useCaseFavorite.getListFavorite { [weak self] data in
            self?.movieFavouriteList.value = data
            print("ini favnya: \(data)")
        }
    }
    
    func deleteFavorite(with id: Int) {
        print("ini movie yg dihapus id: \(id)")
        DispatchQueue.main.async {
            self.useCaseFavorite.deleteFavorite(with: id)
            self.getListFavorite()
        }

    }
}
