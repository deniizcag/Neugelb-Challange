//
//  MovieTableViewCell.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 27.06.2022.
//

import UIKit


class MovieTableViewCell: UITableViewCell {
    
    var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.5
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let movieImage: UIImageView = {
        let movieImage = UIImageView(image: UIImage(named: "sampleImage")!)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.layer.masksToBounds = true
        movieImage.contentMode = .scaleAspectFill
        movieImage.layer.cornerRadius = 30
        return movieImage
    }()
    
    var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Snake Eyes: G.I. Joe Origins"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCardView()
        configureMovieImage()
        configureNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCardView() {
        addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            cardView.heightAnchor.constraint(equalToConstant: 100),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10)
        ])
    }
    
    func configureMovieImage() {
        cardView.addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            movieImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 10),
            movieImage.heightAnchor.constraint(equalToConstant: 60),
            movieImage.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func configureNameLabel() {
        cardView.addSubview(movieNameLabel)
        
        NSLayoutConstraint.activate([
            movieNameLabel.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor,constant: 10),
            movieNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -10),
        ])
    }
    
    func setUI(for movie: Movie,isSelected: Bool) {
        movieNameLabel.text = movie.title
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

