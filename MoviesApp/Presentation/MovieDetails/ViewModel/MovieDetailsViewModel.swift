//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

class MovieDetailsViewModel {
    
    // MARK: - Dependencies
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let movieID: Int
    
    // MARK: - Published Properties
    @Published private(set) var movie: Movie?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Init
    init(fetchMovieDetailsUseCase: FetchMovieDetailsUseCase, movieID: Int) {
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.movieID = movieID
    }
    
    // MARK: - Fetch Movie Details
    func fetchMovieDetails() {
        self.isLoading = true
        
        fetchMovieDetailsUseCase.execute(movieID: movieID) { [weak self] result in
            guard let self = self else { return }
            isLoading = false
            
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                errorMessage = error.userMessage
            }
        }
    }
    
    func toggleFavorite() {
        fetchMovieDetailsUseCase.execute(movieID: movie?.id ?? 0)
        movie?.isFavorite.toggle()
        
        NotificationCenter.default.post(
            name: .favoriteStatusChanged,
            object: nil,
            userInfo: ["movieID": movie?.id ?? 0, "isFavorite": movie?.isFavorite ?? false]
        )
    }
}

