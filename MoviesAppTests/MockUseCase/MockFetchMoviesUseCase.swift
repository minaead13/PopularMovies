//
//  MockFetchMoviesUseCase.swift
//  MoviesAppTests
//
//  Created by OSX on 25/08/2025.
//

import Foundation
@testable import MoviesApp

class MockFetchMoviesUseCase: FetchMoviesUseCase {
    
    var fetchCalled = false
    var shouldReturnError = false
    var stubbedMovies: [Movie] = []
    
    func fetchAllMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        fetchCalled = true
        if shouldReturnError {
            completion(.failure(.unknown))
        } else {
            completion(.success(stubbedMovies))
        }
    }
    
    func toggleFavorite(movieID: Int) {}
    
    func isFavorite(movieID: Int) -> Bool { return false }
}
