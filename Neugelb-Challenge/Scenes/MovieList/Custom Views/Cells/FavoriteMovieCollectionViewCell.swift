//
//  FavoriteMovieCollectionViewCell.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 26.06.2022.
//

import UIKit

class FavoriteMovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "FavoriteMovieCollectionViewCell"
    let movieImage = UIImageView(image: UIImage(named: "sampleImage")!)
    
    var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let padding : CGFloat = 10
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCardView()
        configureMovieImage()
        configureNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImage.layer.cornerRadius = movieImage.frame.size.width / 2
    }
    
    func configureCardView() {
        addSubview(cardView)
        
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cardView.layer.shadowRadius = 6
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false
        
        cardView.backgroundColor = .secondarySystemBackground
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            cardView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
        ])
    }
    
    func configureMovieImage() {
        cardView.addSubview(movieImage)
        
        movieImage.layer.masksToBounds = true
        movieImage.contentMode = .scaleAspectFill
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: cardView.topAnchor,constant: 10),
            movieImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 10),
            movieImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -10),
            movieImage.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func configureNameLabel() {
        cardView.addSubview(movieNameLabel)
        
        movieNameLabel.layer.cornerRadius = 10
        movieNameLabel.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor,constant: 10),
            movieNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
        ])
        
    }
    
    func setUI(for movie: Movie, isSelected: Bool) {
        movieNameLabel.text = movie.title
        movieImage.image = UIImage(named: "sampleImage")!
        if isSelected {
            cardView.layer.borderColor = UIColor.blue.cgColor
            cardView.layer.borderWidth = 3.0
        }
        else {
            cardView.layer.borderColor = UIColor.clear.cgColor
            cardView.layer.borderWidth = 1.0
        }
    }
}

