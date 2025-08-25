//
//  MoviesRepository.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

protocol MoviesRepository {
    func fetchMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void)
    func isFavorite(movieID: Int) -> Bool
    func toggleFavorite(movieID: Int)
}
