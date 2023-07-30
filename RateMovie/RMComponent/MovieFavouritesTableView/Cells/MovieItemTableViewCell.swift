//
//  MovieItemTableViewCell.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var moviePreviewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var onTapFavourite: (() -> Void)?
    
    static let identifier = "MovieItemTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePreviewImageView.contentMode = .scaleAspectFit
        setupShadow()
        setupGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupShadow() {
        let childView = customContentView.layer
        childView.cornerRadius = 12
        childView.borderColor = UIColor.white.cgColor
        childView.shadowOffset = CGSize(width: 10, height: 10)
        childView.shadowRadius = 3
        childView.shadowOpacity = 0.1
        childView.shadowOffset = .zero
        childView.shadowColor = UIColor.white.cgColor
    }
    
    private func setupGesture() {
        let favImageGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFavourite))
        favoriteImageView.isUserInteractionEnabled = true
        favoriteImageView.addGestureRecognizer(favImageGesture)
    }
    
    @objc
    func didTapFavourite() {
        onTapFavourite?()
    }
}
