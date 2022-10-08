//
//  MovieFavouritesViewModel.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import Foundation

protocol MovieFavouritesViewModelInput {
    
}

protocol MovieFavouritesViewModelOutput {
    var errorMessage: Observable<String> { get }
}

protocol MovieFavouritesViewModel: MovieFavouritesViewModelInput, MovieFavouritesViewModelOutput { }

final class DefaultMovieFavouritesViewModel: MovieFavouritesViewModel {
    var errorMessage: Observable<String>
    
    init(errorMessage: Observable<String>) {
        self.errorMessage = errorMessage
    }
    
    
}
