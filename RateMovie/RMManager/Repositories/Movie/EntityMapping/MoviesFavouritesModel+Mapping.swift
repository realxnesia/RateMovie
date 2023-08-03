//
//  MoviesFavouritesModel+Mapping.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import CoreData
import RMDomainEntities

public extension MoviesFavouritesModel {
    public func toMoviesFavouritesEntity(in context: NSManagedObjectContext) -> MoviesFavourite {
        let entity: MoviesFavourite = .init(context: context)
        entity.id = Int64(id ?? 0)
        entity.title = title
        entity.originalLanguage = originalLanguage
        entity.posterPath = posterPath
        entity.voteAverage = Double(voteAverage ?? 0.0)
        return entity
    }
}
