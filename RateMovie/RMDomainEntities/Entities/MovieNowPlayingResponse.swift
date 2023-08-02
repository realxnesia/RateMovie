//
//  MovieNowPlayingResponse.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

struct MovieNowPlayingResponse: Codable {
    let page: Int?
    var results: [Result]?
    let dates: Dates?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    // MARK: - Dates
    struct Dates: Codable {
        let maximum, minimum: String?
    }

    // MARK: - Result
    struct Result: Codable {
        var posterPath: String?
        var adult: Bool?
        var overview, releaseDate: String?
        var genreIDS: [Int]?
        var id: Int?
        var originalTitle: String?
        var originalLanguage: String?
        var title, backdropPath: String?
        var popularity: Double?
        var voteCount: Int?
        var video: Bool?
        var voteAverage: Double?

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
