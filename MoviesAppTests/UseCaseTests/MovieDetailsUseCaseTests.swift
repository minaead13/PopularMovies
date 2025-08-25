//
//  MovieDetailsUseCaseTests.swift
//  MoviesAppTests
//
//  Created by OSX on 25/08/2025.
//

import Foundation

import XCTest
@testable import MoviesApp

final class MovieDetailsUseCaseTests: XCTestCase {
    
    var sut: FetchMovieDetailsUseCase!
    var repository: MockMovieDetailsRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockMovieDetailsRepository()
        sut = FetchMovieDetailsUseCaseImpl(repository: repository)
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }
    
    func test_fetchMovieDetails_success() {
        
        let expectedMovie = Movie(
            id: 1,
            originalLanguage: "en",
            overview: "Nice movie",
            title: "Inception",
            posterPath: "https://google.com",
            releaseDate: "2010-07-16",
            voteAverage: 8.8,
            isFavorite: false
        )
        repository.stubbedMovie = expectedMovie
        
        let expectation = self.expectation(description: "FetchMovieDetailsSuccess")
        var receivedMovie: Movie?
        
        
        sut.execute(movieID: 1) { result in
            if case .success(let movie) = result {
                receivedMovie = movie
                expectation.fulfill()
            }
        }
        
        
        waitForExpectations(timeout: 1)
        XCTAssertEqual(receivedMovie?.id, expectedMovie.id)
        XCTAssertEqual(receivedMovie?.title, expectedMovie.title)
    }
    
    func test_fetchMovieDetails_failure() {
        
        repository.shouldReturnError = true
        
        let expectation = self.expectation(description: "FetchMovieDetailsFailure")
        var receivedError: NetworkError?
        
        
        sut.execute(movieID: 1) { result in
            if case .failure(let error) = result {
                receivedError = error
                expectation.fulfill()
            }
        }
        
        
        waitForExpectations(timeout: 1)
        if case .unknown = receivedError {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected .unknown but got \(String(describing: receivedError))")
        }
    }
}
