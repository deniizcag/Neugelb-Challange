//
//  MovieDetailContracts.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 27.06.2022.
//

import Foundation

protocol MovieDetailProtocol {
    func load()
    var delegate: MovieDetailVMDelegate? {get set}
}

protocol MovieDetailVMDelegate: AnyObject {
    func show(movie: Movie?)
}
