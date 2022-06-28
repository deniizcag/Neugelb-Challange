//
//  MovieDetailVC+UnitTest.swift
//  Neugelb-ChallengeTests
//
//  Created by DENİZÇ on 29.06.2022.
//

import XCTest
@testable import Neugelb_Challenge
class MovieDetailVC_UnitTest: XCTestCase {

  var sut: MovieDetailVC?

  override func setUp() {

    sut = MovieDetailVC()
    sut?.loadViewIfNeeded()

  }

  func testSetViewModel() {
      /// Given:
      
      let movie = Movie(backdropPath: "Test Back", id: 1, originalLanguage: "En", originalTitle: "Test Title", overview: "Overview", popularity: 8.8, posterPath: "Test Poster Path", releaseDate: "2021-09-09", title: "Test Movie", rating: 6.7, isWatched: true)
      
    let viewModel = MovieDetailVM(movie: movie)

    /// : When
    sut?.viewModel = viewModel

    /// : Then
    XCTAssertNotNil(sut?.viewModel)

  }
  func testUpdateView() {
    /// : Given
      
      let movie = Movie(backdropPath: "TestBack", id: 1, originalLanguage: "En", originalTitle: "Test Title", overview: "Overview", popularity: 8.8, posterPath: "Test Poster Path", releaseDate: "2021-09-09", title: "Test Movie", rating: 6.7, isWatched: true)
      let viewModel = MovieDetailVM(movie: movie)

    /// : When
    sut?.viewModel = viewModel
    viewModel.load()

    /// : Then
      XCTAssertEqual(movie.title, sut?.titleLabel.text)

  }

}


