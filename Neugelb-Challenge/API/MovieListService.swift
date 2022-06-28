//
//  MovieListService.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 25.06.2022.
//

import Foundation
import Alamofire
protocol MovieListServiceProtocol {
    func fetchMovieList(completed: @escaping (Result<[Movie], MovieError>) -> Void)
    func fetchFavorite(completed: @escaping ((Result<[Int], MovieError>) -> Void))
}

final class MovieListService: MovieListServiceProtocol {
    
    var movieListURL = "https://61efc467732d93001778e5ac.mockapi.io/movies/list"
    var favoriteMoviesIDsURL = "https://61efc467732d93001778e5ac.mockapi.io/movies/favorites"
    func fetchMovieList(completed: @escaping (Result<[Movie], MovieError>) -> Void) {
        AF.request(movieListURL, method: .get, parameters: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let movieList = try JSONDecoder().decode(RootData.self, from: data!)
                    completed(.success(movieList.results))
                } catch {
                    completed(.failure(.parsingError))
                }
            case .failure(_):
                completed(.failure(.AFError))
            }
        }
    }
    
    func fetchFavorite(completed: @escaping ((Result<[Int], MovieError>) -> Void)) {
        AF.request(favoriteMoviesIDsURL, method: .get, parameters: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let favorites = try JSONDecoder().decode(ID.self, from: data!)
                    let Ids = favorites.results.map { $0.id }
                    completed(.success(Ids))
                } catch {
                    completed(.failure(.parsingError))
                }
        
            case .failure(_):
                completed(.failure(.AFError))
            }
        }
    }
}

enum MovieError: Error {
    case emptyData
    case parsingError
    case AFError
    case networkError
}
