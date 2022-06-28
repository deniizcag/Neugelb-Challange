//
//  MovieDetailViewModel+UnitTest.swift
//  Neugelb-ChallengeTests
//
//  Created by DENİZÇ on 29.06.2022.
//

import XCTest
@testable import Neugelb_Challenge
class MovieDetailViewModel_UnitTest: XCTestCase {
    
    var sut: MovieDetailVM!
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testInitialization() {
        /// Given:
        
        let movie = Movie(backdropPath: "Test Back", id: 1, originalLanguage: "En", originalTitle: "Test Title", overview: "Overview", popularity: 8.8, posterPath: "Test Poster Path", releaseDate: "2021-09-09", title: "Test Movie", rating: 6.7, isWatched: true)
        
        /// : When
        sut = MovieDetailVM(movie: movie)
        
        /// : Then
        XCTAssertNotNil(sut.movie)
    }
    func testMovieDelegate() {
        /// : Given
        
        let movie = Movie(backdropPath: "Test Back", id: 1, originalLanguage: "En", originalTitle: "Test Title", overview: "Overview", popularity: 8.8, posterPath: "Test Poster Path", releaseDate: "2021-09-09", title: "Test Movie", rating: 6.7, isWatched: true)
        let mockDelegate = MockMovieDetailVMDelegate()
        
        /// : When
        sut = MovieDetailVM(movie: movie)
        sut.delegate = mockDelegate
        sut.load()
        
        // : Then
        XCTAssertEqual(sut.movie?.title, mockDelegate.selectedMovie?.title)
        
    }
}

class MockMovieDetailVMDelegate: MovieDetailVMDelegate {
    
    var selectedMovie: Movie?
    func show(movie: Movie?) {
        selectedMovie = movie
    }
    
}

