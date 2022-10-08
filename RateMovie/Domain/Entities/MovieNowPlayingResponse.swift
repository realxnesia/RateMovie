//
//  MovieNowPlayingResponse.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MovieNowPlayingResponse: Codable {
    let page: Int?
    let results: [Result]?
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
