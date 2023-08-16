//
//  MovieItemTableViewCell.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit
import Kingfisher
import RMDomainEntities

public class MovieItemTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var customContentView: UIView!
    @IBOutlet public weak var moviePreviewImageView: UIImageView!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var rateLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    public var viewModel: MovieItemTableViewCellViewModel!
    public var onTapFavourite: (() -> Void)?
     
    public static let identifier = "MovieItemTableViewCell"
    public static func nib() -> UINib {
        UINib(
            nibName: identifier,
            bundle: Bundle(for: Self.self)
        )
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        moviePreviewImageView.contentMode = .scaleAspectFit
        setupShadow()
        setupGesture()
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setView() {
        titleLabel.text = viewModel.title
        rateLabel.text = viewModel.rating
        configurePoster(posterUrl: viewModel.posterUrl)
    }
    
    private func configurePoster(posterUrl: String?) {
        guard let posterUrl else { return }
        moviePreviewImageView.kf.setImage(
            with: URL(string: posterUrl),
            placeholder: UIImage.init(named: ""),
            options: [.transition(.fade(0))],
            progressBlock: nil,
            completionHandler: nil
        )
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
