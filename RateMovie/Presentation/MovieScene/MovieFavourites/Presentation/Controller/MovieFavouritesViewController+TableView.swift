//
//  MovieFavouritesViewController+TableView.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import UIKit
import RMComponents
import RMNetworking

extension MovieFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel?.movieFavouriteList.value?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let movieCell = tableView.dequeueReusableCell(
                withIdentifier: MovieItemTableViewCell.identifier,
                for: indexPath
            ) as? MovieItemTableViewCell
        else { return UITableViewCell() }
        let data = viewModel?.movieFavouriteList.value?[indexPath.row]
        movieCell.titleLabel.text = data?.title
        if let movieRate = data?.voteAverage {
            movieCell.rateLabel.text = "⭐ " + String(movieRate)
        }
        if let url = data?.posterPath,
           let imageUrl = URL(string: Endpoint.Images.baseImage + url)
        {
            movieCell.moviePreviewImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: ""), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
        }
        
        movieCell.onTapFavourite = { [weak self] in
            guard let id = data?.id else { return }
            self?.triggerOnTapUnfavourite(movieId: id)
        }
        return movieCell
    }
}
