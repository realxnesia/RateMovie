//
//  FavoriteNowPlaying.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 10/10/22.
//

import Foundation

public struct FavoriteNowPlaying: Codable {
    public let isFavorite: Bool?
    public let posterPath: String?
    public let adult: Bool?
    public let overview, releaseDate: String?
    public let genreIDS: [Int]?
    public let id: Int?
    public let originalTitle: String?
    public let originalLanguage: String?
    public let title, backdropPath: String?
    public let popularity: Double?
    public let voteCount: Int?
    public let video: Bool?
    public let voteAverage: Double?

    public init(
        isFavorite: Bool?,
        posterPath: String?,
        adult: Bool?,
        overview: String?,
        releaseDate: String?,
        genreIDS: [Int]?,
        id: Int?,
        originalTitle: String?,
        originalLanguage: String?,
        title: String?,
        backdropPath: String?,
        popularity: Double?,
        voteCount: Int?,
        video: Bool?,
        voteAverage: Double?
    ) {
        self.isFavorite = isFavorite
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIDS = genreIDS
        self.id = id
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
    }
}

extension FavoriteNowPlaying {
    public func toMovieListViewModel(baseUrl: String) -> MovieItemCollectionViewViewModel {
        return MovieItemCollectionViewViewModel(
            isFavourite: isFavorite,
            title: title,
            rating: formattedRating,
            language: originalLanguage,
            adult: formattedAdult,
            posterUrl: baseUrl + (posterPath ?? "")
        )
    }
    
    public var formattedRating: String {
        guard let voteAverage else { return "⭐ Unavailable" }
        return "⭐ \(String(describing: voteAverage))/10"
    }
    
    public var formattedAdult: String {
        guard let adult else { return "Content Unknown" }
        return adult
        ? "Movie Adult"
        : "Movie Family Friendly"
    }
}

extension FavoriteNowPlaying {
    public var moviesFavouriteModel: MoviesFavouritesModel {
        return MoviesFavouritesModel(
            id: id,
            title: title,
            originalLanguage: originalLanguage,
            posterPath: posterPath,
            voteAverage: voteAverage
        )
    }
}

