//
//  MovieListService+UnitTest.swift
//  Neugelb-ChallengeTests
//
//  Created by DENİZÇ on 27.06.2022.
//

import Foundation
@testable import Neugelb_Challenge
import XCTest

class MovieListService_UnitTest: XCTestCase {
    
    var service: MovieListService!
    
    override func setUp() {
        super.setUp()
    }
    
    func testFetchMoviesSuccess() {
        let e = expectation(description: "Success")
        
        service = MovieListService()
        
        service.fetchMovieList { result in
            switch result {
            case .success:
                e.fulfill()
            case .failure:
                break
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchMoviesError() {
        let e = expectation(description: "Error")
        
        service = MovieListService()
        service.movieListURL = ""
        
        service.fetchMovieList { result in
            switch result {
            case .success:
                break
            case .failure:
                e.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchFavoriteMoviesSuccess() {
        let e = expectation(description: "Success")
        service = MovieListService()
        
        service.fetchFavorite { result in
            switch result {
            case .success:
                e.fulfill()
            case .failure:
                break
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchFavoriteMoviesFailure() {
        let e = expectation(description: "Success")
        
        service = MovieListService()
        service.favoriteMoviesIDsURL = ""
        
        service.fetchFavorite { result in
            switch result {
            case .success:
                break
            case .failure:
                e.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
