//
//  Movie.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 24.06.2022.
//
import Foundation

// MARK: - Movie
struct RootData: Codable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable, Equatable {
    let backdropPath: String
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let rating: Double
    let isWatched: Bool

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, rating, isWatched
    }
    
    var baseURL: String = "https://image.tmdb.org/t/p/w500/"
    
    var imageURL: String {
           return baseURL + backdropPath
       }
}


