//
//  FavoriteNowPlaying.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 10/10/22.
//

import Foundation

// MARK: - Result
struct FavoriteNowPlaying: Codable {
    let isFavorite: Bool?
    let posterPath: String?
    let adult: Bool?
    let overview, releaseDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title, backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?

//    enum CodingKeys: String, CodingKey {
//        case posterPath = "poster_path"
//        case adult, overview
//        case releaseDate = "release_date"
//        case genreIDS = "genre_ids"
//        case id
//        case originalTitle = "original_title"
//        case originalLanguage = "original_language"
//        case title
//        case backdropPath = "backdrop_path"
//        case popularity
//        case voteCount = "vote_count"
//        case video
//        case voteAverage = "vote_average"
//    }
}
