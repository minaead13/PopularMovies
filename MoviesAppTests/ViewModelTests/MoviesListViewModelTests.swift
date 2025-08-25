//
//  MoviesListViewModelTests.swift
//  MoviesAppTests
//
//  Created by OSX on 25/08/2025.
//

import XCTest
import Combine
@testable import MoviesApp

final class MoviesListViewModelTests: XCTestCase {
    
    var sut: MoviesListViewModel!
    var useCase: MockFetchMoviesUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        useCase = MockFetchMoviesUseCase()
        sut = MoviesListViewModel(fetchMoviesUseCase: useCase)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        useCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_fetchMovies_success() {
        
        let expectedMovies = [
            Movie(id: 1, originalLanguage: "en", overview: "Good movie", title: "Inception", posterPath: "url", releaseDate: "2025-08-25", voteAverage: 4.6)
        ]
        useCase.stubbedMovies = expectedMovies
        
        let expectation = self.expectation(description: "Movies fetched")
        
        
        sut.$movies
            .dropFirst()
            .sink { movies in
               
                XCTAssertEqual(movies.count, expectedMovies.count)
                XCTAssertEqual(movies.first?.title, "Inception")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchMovies()
        
        waitForExpectations(timeout: 1)
    }
    
    func test_fetchMovies_failure() {
    
        useCase.shouldReturnError = true
        let expectation = self.expectation(description: "Movies fetch failed")
        
        
        sut.$errorMessage
            .dropFirst()
            .sink { error in
            
                XCTAssertEqual(error, NetworkError.unknown.userMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchMovies()
        
        waitForExpectations(timeout: 1)
    }

}
