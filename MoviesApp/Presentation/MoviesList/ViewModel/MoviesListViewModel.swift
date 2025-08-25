//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

class MoviesListViewModel {
    
    // MARK: - Dependencies
    private let fetchMoviesUseCase: FetchMoviesUseCase
    weak var coordinator: MoviesCoordinatorProtocol?
    
    // MARK: - Published Properties
    @Published private(set) var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Init
    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        observeFavoriteChanges()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Fetch Movies
    func fetchMovies() {
        isLoading = true
        
        fetchMoviesUseCase.fetchAllMovies { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                self.errorMessage = error.userMessage
            }
        }
    }
    
    func toggleFavorite(at index: Int) {
        let movie = movies[index]
        fetchMoviesUseCase.toggleFavorite(movieID: movie.id)
        movies[index].isFavorite.toggle()
    }
    
    private func observeFavoriteChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavoriteChange(_:)),
            name: .favoriteStatusChanged,
            object: nil
        )
    }
    
    @objc private func handleFavoriteChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let movieID = userInfo["movieID"] as? Int,
              let isFavorite = userInfo["isFavorite"] as? Bool else { return }
        
        if let index = movies.firstIndex(where: { $0.id == movieID }) {
            movies[index].isFavorite = isFavorite
        }
    }
}

