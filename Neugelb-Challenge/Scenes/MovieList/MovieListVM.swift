//
//  MovieListVM.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 24.06.2022.
//

import Foundation


class MovieListVM: MovieListVMProtocol {
    
    
    weak var delegate: MovieListVMDelegate?
    var service: MovieListServiceProtocol
    
    var fetchedMovies: [Movie]?
    var favoriteMovies: [Movie] = []
    var watchedMovies: [Movie] = []
    var toWatchMovies: [Movie] = []
    var selectedMovie: Movie?
    
    init(service: MovieListServiceProtocol) {
        self.service = service
    }
    
    func fetchAllMovies() {
        self.notify(.setLoading(true))
        service.fetchMovieList { result in
            switch result {
            case .success(let movies):
                self.notify(.setLoading(false))
                self.fetchedMovies = self.sortMovies(movies: movies)
                self.watchedMovies = self.sortMovies(movies: movies.filter { $0.isWatched == true })
                self.toWatchMovies = self.sortMovies(movies: movies.filter { $0.isWatched == false })
                self.notify(.showMovieList(self.fetchedMovies))
                self.notify(.showWatchedMovies(self.watchedMovies))
                self.notify(.showToWatchMovies(self.toWatchMovies))
            case .failure(let error):
                self.notify(.setLoading(false))
                self.notify(.error(error))
            }
        }
    }
    
    func sortMovies(movies: [Movie]) -> [Movie] {
        let sorted = movies.sorted(by: { (s1, s2) -> Bool in
            if s1.rating > s2.rating {
                return true
            }
            else if s1.rating < s2.rating {
                return false
            }
            else {
                return s1.title > s2.title ? true : false
            }
        })
        return sorted
    }
    
    func selectMovie(movie: Movie?) {
        self.selectedMovie = movie
        if let movie = movie {
            self.notify(.updateSelectedCellBorder(movie))
            self.notify(.updateButton(true))
        }
        else {
            self.notify(.updateSelectedCellBorder(nil))
            self.notify(.updateButton(false))
        }
    }
    
    func fetchFavoriteMovies(movies: [Movie]?) {
        service.fetchFavorite { result in
            switch result {
            case .success(let Ids):
                let filteredData = self.fetchedMovies?.filter { Ids.contains($0.id) }
                self.favoriteMovies = filteredData!
                self.notify(.showFavoriteMovies(self.favoriteMovies))
                self.addFavoritesToMovies(movies: self.favoriteMovies)
                break
            case .failure(let error):
                self.notify(.error(error))
                break
            }
        }
    }
    
    func addFavoritesToMovies(movies: [Movie]) {
        for movie in movies {
            if !movie.isWatched {
                if !toWatchMovies.contains(movie) {
                    toWatchMovies.append(movie)
                }
            }
        }
        self.notify(.showToWatchMovies(toWatchMovies))
    }
    
    func navigateToDetailScreen(for movie: Movie?) {
        self.notify(.showSelectedMovie(movie!))
    }
    
    func notify(_ outputs: MovieListVMOutput) {
        delegate?.handleViewModelOutputs(outputs)
    }
    
}
