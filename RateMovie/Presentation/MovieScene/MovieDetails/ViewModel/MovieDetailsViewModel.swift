//
//  MovieDetailsViewModel.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

protocol MovieDetailsViewModelInput {
    
}

protocol MovieDetailsViewModelOutput {
    var errorMessage: Observable<String> { get }
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput { }

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    var errorMessage: Observable<String>
    
    init(errorMessage: Observable<String>) {
        self.errorMessage = errorMessage
    }
}
