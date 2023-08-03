//
//  MovieSimilar.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

public struct MovieIdSimilarResponse: Codable {
    public let results: [Result]?
    let totalPages, totalResults, page: Int?

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page
    }
    
    public struct Result: Codable {
        public let genreIDS: [Int]?
        public let adult: Bool?
        public let backdropPath: String?
        public let id: Int?
        public let originalTitle: String?
        public let voteAverage, popularity: Double?
        public let posterPath, overview, title, originalLanguage: String?
        public let voteCount: Int?
        public let releaseDate: String?
        public let video: Bool?

        enum CodingKeys: String, CodingKey {
            case genreIDS = "genre_ids"
            case adult
            case backdropPath = "backdrop_path"
            case id
            case originalTitle = "original_title"
            case voteAverage = "vote_average"
            case popularity
            case posterPath = "poster_path"
            case overview, title
            case originalLanguage = "original_language"
            case voteCount = "vote_count"
            case releaseDate = "release_date"
            case video
        }
    }

}
