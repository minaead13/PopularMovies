//
//  MoviesResponse.swift
//  MoviesApp
//
//  Created by OSX on 08/07/2025.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [MovieDTO]
}

struct Movie {
    let id: Int
    let originalLanguage: String
    let overview: String
    let title: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double
    var isFavorite: Bool = false
}
