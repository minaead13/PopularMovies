//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var favoriteButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configure(data: Movie) {
        nameLabel.text = data.title
        let posterURL = URL(string: "\(Endpoints.posterURL)\(data.posterPath)")
        imageView.kf.setImage(with: posterURL)
        favButton.setImage(UIImage(systemName: data.isFavorite ? "heart.fill" : "heart"), for: .normal)
        rateLabel.text = "\(data.voteAverage)"
        releaseDateLabel.text = data.releaseDate
    }
    
    
    @IBAction func didTapFavButton(_ sender: Any) {
        favoriteButtonAction?()
    }
    
}
