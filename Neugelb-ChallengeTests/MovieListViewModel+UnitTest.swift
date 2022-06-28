//
//  MovieListViewModel+UnitTest.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 28.06.2022.
//

import XCTest
@testable import Neugelb_Challenge
class MovieListViewModel_UnitTest: XCTestCase {
    
    var mockApiService: MockApiService!
    var sut: MovieListVM!
    var expectation: XCTestExpectation?
    
    
    override func setUp() {
        super.setUp()
        mockApiService = MockApiService()
        sut = MovieListVM(service: mockApiService)
        
    }
    
    override func tearDown() {
        super.tearDown()
        mockApiService = nil
        sut = nil
    }
    
    func testFetchMovieSuccess() {
        /// Given:
        
        /// When:
        sut?.fetchAllMovies()
        mockApiService.fetchSuccessMovie()
        
        // : Then
        XCTAssertEqual(sut?.fetchedMovies?.count, 0)
    }
    
    func testFetchMovieFailure() {
        /// Given:
        
        /// When:
        sut?.fetchAllMovies()
        mockApiService.fetchFailMovie(error: .networkError)
        
        // : Then
        XCTAssertNil(sut?.fetchedMovies)
        
    }
    
    func testHandleDelegateOutput() {
        /// Given:
        let movie = Movie(backdropPath: "Test Back", id: 1, originalLanguage: "En", originalTitle: "Test Title", overview: "Overview", popularity: 8.8, posterPath: "Test Poster Path", releaseDate: "2021-09-09", title: "Test Movie", rating: 6.7, isWatched: true)
        let mockDelegate = MockMovieListVMDelegate(testCase: self)
        mockApiService.movieList.append(movie)
        
        /// When:
        sut?.fetchAllMovies()
        mockApiService.fetchSuccessMovie()
        sut.delegate = mockDelegate
        
        mockDelegate.expectisLoading()
        mockDelegate.expectMovieList()
        
        sut.notify(.setLoading(false))
        sut.notify(.showMovieList(mockApiService.movieList))
        
        
        waitForExpectations(timeout: 1)
        let isLoading = try? XCTUnwrap(mockDelegate.isLoading)
        let movieList = try? XCTUnwrap(mockDelegate.movieList)
        
        XCTAssertEqual(isLoading, false)
        XCTAssertEqual(movieList?[0].title, movie.title)

    }
    
    func testHandleDelegateOutput2() {
        /// Given:

        let movie = Movie(backdropPath: "Test Back", id: 1, originalLanguage: "En", originalTitle: "Test Title", overview: "Overview", popularity: 8.8, posterPath: "Test Poster Path", releaseDate: "2021-09-09", title: "Test Movie", rating: 6.7, isWatched: true)
        let mockDelegate = MockMovieListVMDelegate(testCase: self)
        mockApiService.movieList.append(movie)
        mockApiService.favoriteMovies.append(movie)
        
        /// When:
        sut?.fetchAllMovies()
        sut?.fetchFavoriteMovies(movies: sut.fetchedMovies)
        mockApiService.fetchSuccessMovie()
        mockApiService.fetchSuccessMovieIds()
        sut.delegate = mockDelegate
        
        mockDelegate.expectisLoading()
        mockDelegate.expectMovieList()
        mockDelegate.expectFavoriteList()
        
        sut.notify(.setLoading(false))
        sut.notify(.showMovieList(mockApiService.movieList))
        sut.notify(.showFavoriteMovies(mockApiService.favoriteMovies))
        
        waitForExpectations(timeout: 1)
        let isLoading = try? XCTUnwrap(mockDelegate.isLoading)
        let favoriteList = try? XCTUnwrap(mockDelegate.favoriteList)
        
        XCTAssertEqual(isLoading, false)
        XCTAssertEqual(favoriteList?[0].title, movie.title)

    }
    
    //    func testHandleDelegateOutput() {
    //        /// Given:
    //        let movie = Movie(backdropPath: "Test Back", id: 1, originalLanguage: "En", originalTitle: "Test Title", overview: "Overview", popularity: 8.8, posterPath: "Test Poster Path", releaseDate: "2021-09-09", title: "Test Movie", rating: 6.7, isWatched: true)
    //        let mockDelegate = MockPOIListVMDelegate(testCase: self)
    //        mockApiService.poiList.append(poi)
    //
    //        /// When:
    //        sut?.fetchPOIs()
    //        mockApiService.fetchSuccess()
    //        sut.delegate = mockDelegate
    //
    //        mockDelegate.expectisLoading()
    //        mockDelegate.expectPOIList()
    //
    //        sut.notify(.setLoading(false))
    //        sut.notify(.showPOIList(mockApiService.poiList))
    //
    //        /// : Then
    //        waitForExpectations(timeout: 1)
    //        let isLoading = try? XCTUnwrap(mockDelegate.isLoading)
    //        let poiList = try? XCTUnwrap(mockDelegate.poiList)
    //
    //        XCTAssertEqual(isLoading, false)
    //        XCTAssertEqual(poiList?[0].addressInfo.title, poi.addressInfo.title)
    //
    //    }
    
    
}

class MockApiService: MovieListServiceProtocol {
    var completeClosureMovie: ((Result<[Movie], MovieError>) -> Void)!
    var completeClosureMovieIDs: ((Result<[Int], MovieError>) -> Void)!
    var movieList = [Movie]()
    var idList = [Int]()
    var favoriteMovies = [Movie]()
    
    func fetchMovieList(completed: @escaping (Result<[Movie], MovieError>) -> Void) {
        completeClosureMovie = completed
    }
    
    func fetchFavorite(completed: @escaping ((Result<[Int], MovieError>) -> Void)) {
        completeClosureMovieIDs = completed
    }
    func fetchSuccessMovie() {
        completeClosureMovie(.success(movieList))
    }
    
    func fetchFailMovie(error: MovieError) {
        completeClosureMovie(.failure(error))
    }
    
    func fetchSuccessMovieIds() {
        completeClosureMovieIDs(.success(idList))
    }
    
    func fetchFailMovieIds(error: MovieError) {
        completeClosureMovieIDs(.failure(error))
    }
    
}

class MockMovieListVMDelegate: MovieListVMDelegate {
    
    
    private var expectationLoading: XCTestExpectation?
    private var expectationMovieList: XCTestExpectation?
    private var expectationFavoriteList: XCTestExpectation?
    private var expectationWatchedList: XCTestExpectation?
    private var expectationToWatchList: XCTestExpectation?
    private var expectationIsButtonEnabled: XCTestExpectation?
    private var expectationIsSelectedCell: XCTestExpectation?
    private var expectationIsSelectedMovie: XCTestExpectation?
    
    private var expectationRouting: XCTestExpectation?
    private let testCase: XCTestCase
    var movie: Movie?
    var isLoading: Bool?
    var title: String?
    var movieList: [Movie]?
    var favoriteList: [Movie]?
    var watchedList: [Movie]?
    var toWatchList: [Movie]?
    var isButtonEnabled: Bool?
    var isSelected: Bool?
    
    var selectedVC: MovieDetailVC?
    var navigationController: UINavigationController?
    
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }
    
    func expectMovieList() {
        expectationMovieList = testCase.expectation(description: "Movie List Error")
    }
    
    func expectFavoriteList() {
        expectationFavoriteList = testCase.expectation(description: "Favorite List Error")
    }
    
    func expectWatchedList() {
        expectationMovieList = testCase.expectation(description: "Watched List Error")
    }
    
    func expectToWatchList() {
        expectationToWatchList = testCase.expectation(description: "To Watch List Error")
    }
    
    func expectisLoading() {
        expectationLoading = testCase.expectation(description: "isLoading not working")
    }
    
    func expectisButtonEnabled() {
        expectationIsButtonEnabled = testCase.expectation(description: "Button Enable Error")
    }
    
    func expectisCellSelected() {
        expectationIsSelectedCell = testCase.expectation(description: "Cell Selection Error")
    }
    
    func expectRouting() {
        expectationRouting = testCase.expectation(description: "Routing Detail Screen Error")
    }
    
    func handleViewModelOutputs(_ output: MovieListVMOutput) {
        switch output {
        case .setLoading(let isLoading):
            if expectationLoading != nil {
                self.isLoading = isLoading
            }
            expectationLoading?.fulfill()
            expectationLoading = nil
        case .showMovieList(let movieList):
            if expectationMovieList != nil {
                self.movieList = movieList
            }
            expectationMovieList?.fulfill()
            expectationMovieList = nil
        case .showFavoriteMovies(let favorites):
            if expectationFavoriteList != nil {
                self.favoriteList = favorites
            }
            expectationFavoriteList?.fulfill()
            expectationFavoriteList = nil
        case .showWatchedMovies(let watched):
            if expectationWatchedList != nil {
                self.watchedList = watched
            }
            expectationMovieList?.fulfill()
            expectationMovieList = nil
        case .showToWatchMovies(let toWatch):
            if expectationToWatchList != nil {
                self.watchedList = toWatch
            }
            expectationToWatchList?.fulfill()
            expectationToWatchList = nil
        case .updateButton(let isEnabled):
            if expectationIsButtonEnabled != nil {
                self.isButtonEnabled = isEnabled
            }
            expectationIsButtonEnabled?.fulfill()
            expectationIsButtonEnabled = nil
        case .showSelectedMovie(let movie):
            if expectationRouting != nil {
                self.movie = movie
                self.selectedVC = MovieDetailBuilder.make(movie: movie)
                self.navigationController = UINavigationController(rootViewController: selectedVC!)
            }
            expectationRouting?.fulfill()
            expectationRouting = nil
            
        case .updateSelectedCellBorder(let selectedMovie):
            if expectationIsSelectedCell != nil {
                self.movie = selectedMovie
            }
            expectationIsSelectedCell?.fulfill()
            expectationIsSelectedCell = nil
        case .error(_):
            break
        }
    }
}


