//
//  MoviesRemoteDataSourceImpl.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

class MoviesRepositoryImpl: MoviesRepository {
    
    private let apiClient: APIClient
    private let localDataSource: FavoritesLocalDataSource
    
    init(apiClient: APIClient, localDataSource: FavoritesLocalDataSource) {
        self.apiClient = apiClient
        self.localDataSource = localDataSource
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        guard let request = Endpoints.getPopularMoviesRequest() else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        apiClient.request(request) { (result: Result<MoviesResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let movies = response.results.map { dto in
                    var movie = dto.toDomain()
                    movie.isFavorite = self.isFavorite(movieID: dto.id)
                    return movie
                }
                completion(.success(movies))
            case .failure(let networkError):
                completion(.failure(networkError))
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

