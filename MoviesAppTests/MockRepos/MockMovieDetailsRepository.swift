//
//  MockMovieDetailsRepository.swift
//  MoviesAppTests
//
//  Created by OSX on 25/08/2025.
//

import Foundation
@testable import MoviesApp

final class MockMovieDetailsRepository: MovieDetailsRepository {
    
    var shouldReturnError = false
    var stubbedMovie: Movie?
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.unknown))
        } else if let movie = stubbedMovie {
            completion(.success(movie))
        }
    }
    
    func isFavorite(movieID: Int) -> Bool {
        return false
    }
    
    func toggleFavorite(movieID: Int) {}
}
