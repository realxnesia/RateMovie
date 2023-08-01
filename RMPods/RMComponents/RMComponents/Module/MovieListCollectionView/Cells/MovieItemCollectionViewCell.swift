//
//  MovieItemCollectionViewCell.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit

public class MovieItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var moviePreviewImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var movieFavoriteImageView: UIImageView!
    
    public var onFavouriteTapped: (() -> Void)?
    
    public static let identifier = "MovieItemCollectionViewCell"
    public static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    public static func bundleNib() -> UINib {
        UINib(nibName: identifier, bundle: Bundle(for: self.self))
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        moviePreviewImageView.contentMode = .scaleAspectFit
        setupGesture()
        setupShadow()
    }
    
    public func setView(
        movieTitle: String,
        movieRate: String,
        movieLanguage: String
    ) {
        movieTitleLabel.text = movieTitle
        movieRateLabel.text = "⭐ \(String(describing: movieRate))/10"
        movieLanguageLabel.text = movieLanguage
    }
    
    public func setMovieFavoriteImageView(status: Bool) {
        if #available(iOS 13.0, *) {
            moviePreviewImageView.image = status
            ? UIImage(systemName: "bookmark.fill")
            : UIImage(systemName: "bookmark")
        } else {
            // Fallback on earlier versions
        }
    }
    
    public func getFavouriteView() -> UIView {
        return favoriteView
    }
    
    public func getMoviePreviewImageView() -> UIImageView {
        return moviePreviewImageView
    }
    
    public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    private func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favoriteView.isUserInteractionEnabled = true
        favoriteView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        onFavouriteTapped?()
    }
    
    private func setupShadow() {
        self.containerView.layer.cornerRadius = 12
        self.containerView.layer.borderColor = UIColor.red.cgColor
        self.containerView.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.containerView.layer.shadowRadius = 3
        self.containerView.layer.shadowOpacity = 0.1
        self.containerView.layer.shadowOffset = .zero
        self.containerView.layer.shadowColor = UIColor.red.cgColor
        self.containerView.clipsToBounds = true
    }
    

}
