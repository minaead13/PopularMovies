//
//  MockMoviesRepository.swift
//  MoviesAppTests
//
//  Created by OSX on 25/08/2025.
//

import Foundation
@testable import MoviesApp

class MockMoviesRepository: MoviesRepository {
    
    var stubbedMovies: [Movie] = []
    var shouldReturnError = false
    
    func fetchMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.unknown))
        } else {
            completion(.success(stubbedMovies))
        }
    }
    
    func isFavorite(movieID: Int) -> Bool { return false }
    
    func toggleFavorite(movieID: Int) {}
}
