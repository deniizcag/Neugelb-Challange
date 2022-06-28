//
//  MovieDetailVM.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 27.06.2022.
//

import Foundation

class MovieDetailVM: MovieDetailProtocol {
    weak var delegate: MovieDetailVMDelegate?
    var movie: Movie?
    
    init(movie: Movie?) {
        self.movie = movie
    }
    
    func load() {
        delegate?.show(movie: self.movie)
    }
    
}
