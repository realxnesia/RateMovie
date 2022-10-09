//
//  MovieListViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {

    private var movieResult: [MovieNowPlayingResponse.Result]?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: DefaultCollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint! //collection harusnya yg punya height bukan viewnya.
    private var viewModel: MovieListViewModel = DefaultMovieListViewModel()
}

extension MovieListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
//        viewModel.getMovieNowPlaying()
        verticalCollectionConfigure()
        bind()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = UIScreen.main.bounds.height
        
        let recommendationHeight = collectionView.collectionViewLayout.collectionView?.contentSize.height
        collectionViewHeight.constant = recommendationHeight ?? 0
        self.view.layoutIfNeeded()
    }
    
    
}

extension MovieListViewController {
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
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as? MovieItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let data = viewModel.movieList.value[indexPath.row]
        movieCell.movieTitleLabel.text = data.title
        movieCell.movieRateLabel.text = "⭐ \(String(describing: data.voteAverage))"
        movieCell.movieLanguageLabel.text = data.originalLanguage
        if let url = data.posterPath, let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
            movieCell.moviePreviewImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: ""), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
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
        let screenSize = UIScreen.main.bounds
        return CGSize(width: screenSize.width/3 - 16, height: screenSize.height/3 - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 8, bottom: 0, right: 8)
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
