//
//  FavoritesTableViewCell.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 26.06.2022.
//

import UIKit

protocol FavoritesTableViewCellDelegate {
    func favoritesTableViewCellDelegateMovieSelected(movie: Movie)
}

class FavoritesTableViewCell: UITableViewCell {
    
    var favoriteMovies: [Movie] = [] {
        didSet {
            self.movieCollectionView.reloadData()
        }
    }
    var selectedMovie: Movie?
    var delegate: FavoritesTableViewCellDelegate?
    
    let movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 140)
        layout.minimumInteritemSpacing = 30
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
        contentView.addSubview(movieCollectionView)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.showsHorizontalScrollIndicator = false
        movieCollectionView.showsVerticalScrollIndicator = false
        movieCollectionView.register(FavoriteMovieCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteMovieCollectionViewCell.reuseID)
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieCollectionView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
}

extension FavoritesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMovieCollectionViewCell.reuseID, for: indexPath) as! FavoriteMovieCollectionViewCell
        let movie = favoriteMovies[indexPath.row]
        cell.setUI(for: movie, isSelected: movie == self.selectedMovie)
        cell.movieImage.kf.setImage(with: URL(string: favoriteMovies[indexPath.row].imageURL))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.favoritesTableViewCellDelegateMovieSelected(movie: favoriteMovies[indexPath.row])
        self.movieCollectionView.reloadData()
    }
}
