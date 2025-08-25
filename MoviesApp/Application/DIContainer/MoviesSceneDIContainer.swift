//
//  MoviesSceneDIContainer.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - Singleton
    
    static let shared = AppDIContainer()
    private init() {}
    
    // MARK: - Network
    
    private func makeAPIClient() -> APIClient {
        return NetworkService()
    }
    
    // MARK: - Local Storage
    
    private func makeFavoritesLocalDataSource() -> FavoritesLocalDataSource {
        return FavoritesLocalDataSourceImpl()
    }
    
    // MARK: - Repositories
    
    func makeMoviesRepository() -> MoviesRepository {
        return MoviesRepositoryImpl(apiClient: makeAPIClient(), localDataSource: makeFavoritesLocalDataSource())
    }
    
    func makeMovieDetailsRepository() -> MovieDetailsRepository {
        return MovieDetailsRepositoryImpl(apiClient: makeAPIClient(), localDataSource: makeFavoritesLocalDataSource())
    }
    
    // MARK: - UseCases
    
    func makeFetchMoviesUseCase() -> FetchMoviesUseCase {
        return FetchMoviesUseCaseImpl(repository: makeMoviesRepository())
    }
    
    func makeFetchMovieDetailsUseCase() -> FetchMovieDetailsUseCase {
        return FetchMovieDetailsUseCaseImpl(repository: makeMovieDetailsRepository())
    }
    
    // MARK: - ViewModels
    
    func makeMoviesListViewModel() -> MoviesListViewModel {
        return MoviesListViewModel(fetchMoviesUseCase: makeFetchMoviesUseCase())
    }
    
}
