//
//  MovieNowPlayingResponse.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

public struct MovieNowPlayingResponse: Codable {
    let page: Int?
    public var results: [Result]?
    let dates: Dates?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    struct Dates: Codable {
        let maximum, minimum: String?
    }

    public struct Result: Codable {
        public var posterPath: String?
        public var adult: Bool?
        public var overview, releaseDate: String?
        public var genreIDS: [Int]?
        public var id: Int?
        public var originalTitle: String?
        public var originalLanguage: String?
        public var title, backdropPath: String?
        public var popularity: Double?
        public var voteCount: Int?
        public var video: Bool?
        public var voteAverage: Double?

        enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
            case adult, overview
            case releaseDate = "release_date"
            case genreIDS = "genre_ids"
            case id
            case originalTitle = "original_title"
            case originalLanguage = "original_language"
            case title
            case backdropPath = "backdrop_path"
            case popularity
            case voteCount = "vote_count"
            case video
            case voteAverage = "vote_average"
        }
    }

    enum OriginalLanguage: String, Codable {
        case en = "en"
        case sv = "sv"
    }
}
