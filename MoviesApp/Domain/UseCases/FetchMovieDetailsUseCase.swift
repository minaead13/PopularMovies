//
//  FetchMovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

protocol FetchMovieDetailsUseCase {
    func execute(movieID: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void)
    func execute(movieID: Int)
    func isFavorite(movieID: Int) -> Bool
}

class FetchMovieDetailsUseCaseImpl: FetchMovieDetailsUseCase {
    
    private let repository: MovieDetailsRepository
    
    init(repository: MovieDetailsRepository) {
        self.repository = repository
    }
    
    func execute(movieID: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        repository.fetchMovieDetails(movieID: movieID) { (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let movie):
                completion(.success(movie))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }
    
    func execute(movieID: Int) {
        repository.toggleFavorite(movieID: movieID)
    }
    
    func isFavorite(movieID: Int) -> Bool {
        return repository.isFavorite(movieID: movieID)
    }
}
