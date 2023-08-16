//
//  MoviesFavourite.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 09/10/22.
//

import Foundation

public struct MoviesFavouritesModel {
    public let id: Int?
    public let title: String?
    public let originalLanguage: String?
    public let posterPath: String?
    public let voteAverage: Double?
    public init(
        id: Int?,
        title: String?,
        originalLanguage: String?,
        posterPath: String?,
        voteAverage: Double?
    ) {
        self.id = id
        self.title = title
        self.originalLanguage = originalLanguage
        self.posterPath = posterPath
        self.voteAverage = voteAverage
    }
}

extension MoviesFavouritesModel {
    public func toMovieListCollectionViewViewModel(baseUrl: String) -> MovieItemTableViewCellViewModel {
        return MovieItemTableViewCellViewModel(
            title: title,
            rating: formattedRating,
            posterUrl: baseUrl + (posterPath ?? "")
        )
    }
    
    public var formattedRating: String {
        guard let voteAverage else { return "⭐ Unavailable" }
        return "⭐ \(String(describing: voteAverage))/10"
    }
}
