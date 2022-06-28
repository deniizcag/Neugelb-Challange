//
//  MovieListBuilder.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 24.06.2022.
//

import Foundation

final class MovieListBuilder {
    
    static func make() -> MovieListVC {
        let viewController = MovieListVC()
        viewController.viewModel = MovieListVM(service: app.service)
        return viewController
    }
}
