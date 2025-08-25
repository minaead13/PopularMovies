//
//  MovieDetailsRepository.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

protocol MovieDetailsRepository {
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void)
    func isFavorite(movieID: Int) -> Bool
    func toggleFavorite(movieID: Int)
}
