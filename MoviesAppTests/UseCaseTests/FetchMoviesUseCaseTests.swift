//
//  FetchMoviesUseCaseTests.swift
//  MoviesAppTests
//
//  Created by OSX on 25/08/2025.
//

import XCTest
@testable import MoviesApp

final class FetchMoviesUseCaseTests: XCTestCase {
    
    var sut: FetchMoviesUseCase!
    var repository: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockMoviesRepository()
        sut = FetchMoviesUseCaseImpl(repository: repository)
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }
    
    func test_fetchMovies_shouldCallRepository() {
        let expectedMovies = [Movie(
            id: 1,
            originalLanguage: "en",
            overview: "Very good",
            title: "Inception",
            posterPath: "https://google.com",
            releaseDate: "5/08/2025",
            voteAverage: 4.6)
        ]
        repository.stubbedMovies = expectedMovies
        
        let expectation = self.expectation(description: "FetchMoviesSuccess")
        var receivedMovies: [Movie]?
        
        sut.fetchAllMovies { result in
            if case .success(let movies) = result {
                receivedMovies = movies
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
        XCTAssertEqual(receivedMovies?.count, expectedMovies.count)
        XCTAssertEqual(receivedMovies?.first?.title, "Inception")
    }
    
    func test_fetchMovies_failure() {
        
        repository.shouldReturnError = true
        
        let expectation = self.expectation(description: "FetchMoviesFailure")
        var receivedError: NetworkError?
        
        
        sut.fetchAllMovies { result in
            if case .failure(let error) = result {
                receivedError = error
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
        if case .unknown = receivedError {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected .unknown error, but got \(String(describing: receivedError))")
        }
    }

}
