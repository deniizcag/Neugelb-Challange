//
//  MovieDetailVC.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 27.06.2022.
//

import UIKit

class MovieDetailVC: UIViewController {
    var viewModel: MovieDetailProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var movieImageView: UIImageView = {
        var imageView = UIImageView()
        imageView = UIImageView(image: UIImage(named: "sampleImage")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ratingLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var languageLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        view.backgroundColor = .systemBackground
        title = "Details"
        configureTitleLabel()
        configureDescriptionLabel()
        configureRatingLabel()
        configureDateLabel()
        configureLanguageLabel()
        viewModel?.load()
    }
    
    func configureImageView() {
        view.addSubview(movieImageView)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            movieImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
        ])
    }
    
    func configureDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
        ])
    }
    
    func configureRatingLabel() {
        view.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
        ])
    }
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor,constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
        ])
    }
    
    func configureLanguageLabel() {
        view.addSubview(languageLabel)
        
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 20),
            languageLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
        ])
    }
}

extension MovieDetailVC: MovieDetailVMDelegate {
    func show(movie: Movie?) {
        if let movie = movie {
            titleLabel.text = movie.title
            descriptionLabel.text = movie.overview
            dateLabel.text = movie.releaseDate
            ratingLabel.text = "Rating: \(movie.rating)"
            languageLabel.text = "Language: \(String(describing: movie.originalLanguage.uppercased()))"
            movieImageView.kf.setImage(with: URL(string: movie.imageURL)!)
        }
    }
}
