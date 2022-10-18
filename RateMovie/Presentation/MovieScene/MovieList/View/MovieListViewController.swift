//
//  MovieListViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController, RedNavBar {

    private var movieResult: [MovieNowPlayingResponse.Result]?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: DefaultCollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint! //collection harusnya yg punya height bukan viewnya.
    private var viewModel: MovieListViewModel = DefaultMovieListViewModel()
}

extension MovieListViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBackground()
        viewModel.getMovieNowPlaying()
//        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        verticalCollectionConfigure()
        bind()
        setupView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = UIScreen.main.bounds.height
        
        let recommendationHeight = collectionView.collectionViewLayout.collectionView?.contentSize.height
        collectionViewHeight.constant = recommendationHeight ?? 0
        self.view.layoutIfNeeded()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetNavigationBackground()
    }
}

extension MovieListViewController {
    private func setupView () {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Movie"
    }
    private func verticalCollectionConfigure() {
        collectionView.isBouncesVertical = true
    }
    
    private func updateCollectionViewHeights() {
        self.collectionViewHeight.constant = self.collectionView.layoutContentSizeHeight
        self.view.layoutIfNeeded()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MovieItemCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieItemCollectionViewCell.identifier)
    }
    
    private func bind() {
        viewModel.movieList.observe(on: self) { [weak self] moviee in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.updateCollectionViewHeights()
        }
//        viewModel.movieListResultFiltered.observe(on: self) { [weak self] moviee in
//            guard let self = self else { return }
//            self.collectionView.reloadData()
//            self.updateCollectionViewHeights()
//        }
    }

}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieList.value.count
//        return viewModel.movieListResultFiltered.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as? MovieItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let data = viewModel.movieList.value[indexPath.row]
        movieCell.movieTitleLabel.text = data.title
        if let movieRate = data.voteAverage {
            movieCell.movieRateLabel.text = "⭐ \(String(describing: movieRate))/10"
        }
        movieCell.movieLanguageLabel.text = data.originalLanguage
        if let url = data.posterPath, let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
            movieCell.moviePreviewImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: ""), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
        }
        
        movieCell.movieFavoriteImageView.image = data.isFavorite! ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")

        
        movieCell.onFavouriteTapped = { [weak self] in
            let id = data.id
            let title = data.title
            let originalLanguage = data.originalLanguage
            let posterPath = data.posterPath
            let voteAverage = data.voteAverage
            let selectedData = MoviesFavouritesModel(id: id,
                                                   title: title,
                                                   originalLanguage: originalLanguage,
                                                   posterPath: posterPath,
                                                   voteAverage: voteAverage)
            if let isFavorite = data.isFavorite {
                if isFavorite {
                    self?.viewModel.deleteFavorite(with: id!)
                    movieCell.movieFavoriteImageView.image = UIImage(systemName: "bookmark")
                } else {
                    self?.viewModel.addMovieToFavorite(which: selectedData)
                    movieCell.movieFavoriteImageView.image = UIImage(systemName: "bookmark.fill")
                }

            }
//            self?.viewModel.getMovieNowPlaying()
        }
        
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.movieList.value[indexPath.row]
        let vc = MovieDetailsViewController()
        if let movieId = data.id {
            let vm = DefaultMovieDetailsViewModel(movieId: movieId)
            vc.viewModel = vm
        }
        vc.movieResult = data
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let twoColumnCellWidth = (width - 40) / 3

        return CGSize(width: twoColumnCellWidth, height: width / 2 + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension UICollectionView {
    func reloads() {
        DispatchQueue.main.async {
            self.reloadData()
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    private var defaultCollectionViewHeight: CGFloat {
        guard let refresh = refreshControl?.bounds else { return 0 }
        return refresh.height + 50
    }
    
    var layoutContentSizeHeight: CGFloat {
        let height = collectionViewLayout.collectionViewContentSize.height
        return height != 0 ? height : defaultCollectionViewHeight
    }
}
