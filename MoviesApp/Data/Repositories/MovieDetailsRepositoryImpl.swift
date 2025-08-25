//
//  MovieDetailsRepositoryImpl.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

class MovieDetailsRepositoryImpl: MovieDetailsRepository {
    
    private let apiClient: APIClient
    private let localDataSource: FavoritesLocalDataSource
    
    init(apiClient: APIClient, localDataSource: FavoritesLocalDataSource) {
        self.apiClient = apiClient
        self.localDataSource = localDataSource
    }
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        
        guard let request = Endpoints.getMovieDetailsRequest(movieID: movieID) else {
            completion(.failure(.invalidURL))
            return
        }
        
        apiClient.request(request) { (result: Result<MovieDTO, NetworkError>) in
            switch result {
            case .success(let dto):
                var movie = dto.toDomain()
                movie.isFavorite = self.isFavorite(movieID: dto.id)
                completion(.success(movie))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func isFavorite(movieID: Int) -> Bool {
        return localDataSource.isFavorite(movieID: movieID)
    }
    
    func toggleFavorite(movieID: Int) {
        localDataSource.toggleFavorite(movieID: movieID)
    }
}
