//
//  MovieFavouritesViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit

class MovieFavouritesViewController: UIViewController, RedNavBar {

    @IBOutlet weak var tableView: UITableView!
    
//    private var viewModel: MovieFavouritesViewModel = DefaultMovieFavouritesViewModel()
     var viewModel: MovieFavouritesViewModel!
}

extension MovieFavouritesViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBackground()
        self.viewModel?.getListFavorite()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite"
        configureTableView()
        bind()
    }
}

extension MovieFavouritesViewController {
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieItemTableViewCell.nib(), forCellReuseIdentifier: MovieItemTableViewCell.identifier)
    }
    
    private func bind() {
        viewModel?.movieFavouriteList.observe(on: self) { [weak self] movieFavorites in
//            if movieFavorites.count != 0 {
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
//            }
        }
    }
}

extension MovieFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movieFavouriteList.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieItemTableViewCell.identifier, for: indexPath) as? MovieItemTableViewCell
        else {
            return UITableViewCell()
        }
        let data = viewModel?.movieFavouriteList.value[indexPath.row]
        movieCell.titleLabel.text = data?.title
        if let movieRate = data?.voteAverage {
            movieCell.rateLabel.text = "⭐ " + String(movieRate)
        }
        if let url = data?.posterPath, let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
            movieCell.moviePreviewImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: ""), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
        }
        movieCell.onTapFavourite = { [weak self] in
            guard let movieId = data?.id else { return }
            DispatchQueue.main.async {
                self?.viewModel?.deleteFavorite(with: movieId)
            }
            
//            self?.viewModel.getListFavorite()
//            self?.tableView.reloadData()
//            self?.viewModel.getListFavorite()
            print("ini movie yg dihapus: \(data)")
        }
        return movieCell
    }
    
}
