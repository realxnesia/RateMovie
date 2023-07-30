//
//  MovieDetailsViewController+CollectionView.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import UIKit

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel?.movieSimilar.value.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let movieItem = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as? MovieItemCollectionViewCell,
           let data = viewModel?.movieSimilar.value[indexPath.row],
           let voteAverage = data.voteAverage
        {
            movieItem.movieTitleLabel.text = data.originalTitle
            movieItem.movieRateLabel.text = "⭐ \(String(describing: voteAverage))"
            movieItem.movieLanguageLabel.text = data.originalLanguage
            movieItem.favoriteView.isHidden = true
            movieItem.movieFavoriteImageView.isHidden = true
            
            if let url = data.posterPath,
                let imageUrl = URL(string: Endpoint.Images.baseImage + url)
            {
                movieItem.moviePreviewImageView.kf.setImage(
                    with: imageUrl,
                    placeholder: UIImage.init(named: ""),
                    options: [.transition(.fade(0))],
                    progressBlock: nil,
                    completionHandler: nil
                )
            }
            return movieItem
        }
        return UICollectionViewCell()
    }
}
