//
//  MovieDTO.swift
//  MoviesApp
//
//  Created by OSX on 10/07/2025.
//

import Foundation

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    let originalLanguage: String
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

extension MovieDTO {
    func toDomain() -> Movie {
        return Movie(
            id: id,
            originalLanguage: originalLanguage,
            overview: overview,
            title: title,
            posterPath: posterPath ?? "",
            releaseDate: releaseDate,
            voteAverage: voteAverage
        )
    }
}
