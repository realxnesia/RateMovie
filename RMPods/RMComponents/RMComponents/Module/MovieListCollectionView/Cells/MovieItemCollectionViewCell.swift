//
//  MovieItemCollectionViewCell.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit

public class MovieItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet public weak var favoriteView: UIView!
    @IBOutlet public weak var moviePreviewImageView: UIImageView!
    @IBOutlet public weak var movieTitleLabel: UILabel!
    @IBOutlet public weak var movieRateLabel: UILabel!
    @IBOutlet public weak var movieLanguageLabel: UILabel!
    @IBOutlet public weak var movieFavoriteImageView: UIImageView!
    
    public var onFavouriteTapped: (() -> Void)?
    
    public static let identifier = "MovieItemCollectionViewCell"
    public static func nib() -> UINib {
        UINib(
            nibName: identifier,
            bundle: Bundle(for: Self.self)
        )
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        moviePreviewImageView.contentMode = .scaleAspectFit
        setupGesture()
        setupShadow()
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
