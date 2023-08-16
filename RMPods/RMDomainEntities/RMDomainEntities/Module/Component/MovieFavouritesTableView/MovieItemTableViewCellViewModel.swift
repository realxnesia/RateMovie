//
//  MovieItemTableViewCellViewModel.swift
//  Alamofire
//
//  Created by realxnesia on 16/08/23.
//

import Foundation

public struct MovieItemTableViewCellViewModel {
    public let title: String?
    public let rating: String?
    public let posterUrl: String?
    init(
        title: String?,
        rating: String?,
        posterUrl: String?
    ) {
        self.title = title
        self.rating = rating
        self.posterUrl = posterUrl
    }
}
