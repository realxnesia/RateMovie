//
//  MoviesFavourite+DTO.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import CoreData
import RateMovie

extension MoviesFavourite {    
    func toDTO() -> MoviesFavouritesModel {
        return MoviesFavouritesModel.init(
            id: Int(id),
            title: title,
            originalLanguage: originalLanguage,
            posterPath: posterPath,
            voteAverage: voteAverage
        )
    }
}
