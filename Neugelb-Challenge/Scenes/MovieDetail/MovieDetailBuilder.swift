//
//  MovieDetailBuilder.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 27.06.2022.
//

import Foundation

final class MovieDetailBuilder {
    static func make(movie: Movie?) -> MovieDetailVC {
        let viewController = MovieDetailVC()
        viewController.viewModel = MovieDetailVM(movie: movie)
        return viewController
    }
}
