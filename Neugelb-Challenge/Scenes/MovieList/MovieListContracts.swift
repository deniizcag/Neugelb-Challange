//
//  MovieListContracts.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 24.06.2022.
//

import Foundation

protocol MovieListVMProtocol {
    var delegate: MovieListVMDelegate? {get set}
    var selectedMovie: Movie? {get set}
    var fetchedMovies: [Movie]? {get set}
    func fetchAllMovies()
    func selectMovie(movie: Movie?)
    func fetchFavoriteMovies(movies: [Movie]?)
    func navigateToDetailScreen(for movie: Movie?)
    func sortMovies(movies: [Movie]) -> [Movie]
}

enum MovieListVMOutput {
    case setLoading(Bool)
    case showMovieList([Movie]?)
    case showFavoriteMovies([Movie])
    case showWatchedMovies([Movie])
    case showToWatchMovies([Movie])
    case updateButton(Bool)
    case showSelectedMovie(Movie)
    case updateSelectedCellBorder(Movie?)
    case error(MovieError)
}

protocol MovieListVMDelegate: AnyObject {
    func handleViewModelOutputs(_ output: MovieListVMOutput)
}
