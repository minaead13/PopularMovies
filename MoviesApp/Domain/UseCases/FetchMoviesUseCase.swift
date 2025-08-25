//
//  HomeMoviesUseCase.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

protocol FetchMoviesUseCase {
    func fetchAllMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void)
    func toggleFavorite(movieID: Int)
    func isFavorite(movieID: Int) -> Bool
}

class FetchMoviesUseCaseImpl: FetchMoviesUseCase {
   
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func fetchAllMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        repository.fetchMovies { (result: Result<[Movie], NetworkError>) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
        
    }
    
    func toggleFavorite(movieID: Int) {
        repository.toggleFavorite(movieID: movieID)
    }
    
    func isFavorite(movieID: Int) -> Bool {
        return repository.isFavorite(movieID: movieID)
    }
}
