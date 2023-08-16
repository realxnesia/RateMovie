//
//  MovieItemCollectionViewViewModel.swift
//  Alamofire
//
//  Created by realxnesia on 16/08/23.
//

import Foundation

public struct MovieItemCollectionViewViewModel {
    public let isFavourite: Bool?
    public let title: String?
    public let rating: String?
    public let language: String?
    public let adult: String?
    public let posterUrl: String?
    public init(
        isFavourite: Bool?,
        title: String?,
        rating: String?,
        language: String?,
        adult: String?,
        posterUrl: String?
    ) {
        self.isFavourite = isFavourite
        self.title = title
        self.rating = rating
        self.language = language
        self.adult = adult
        self.posterUrl = posterUrl
    }
}
