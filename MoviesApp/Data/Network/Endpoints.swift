//
//  Endpoints.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

struct Endpoints {
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "6f308e7e00ccae6840de46729f6668ae"
    static let posterURL = "https://image.tmdb.org/t/p/w500"
    
    static func makeRequest(path: String, queryItems: [URLQueryItem]) -> URLRequest? {
        var components = URLComponents(string: "\(baseURL)\(path)")
        components?.queryItems = ([URLQueryItem(name: "api_key", value: apiKey)] + queryItems)
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    static func getPopularMoviesRequest(
        year:Int = 2024,
        sortBy: String = "vote_average.desc",
        language: String = "en-US",
        page: Int = 1
    ) -> URLRequest? {
        return makeRequest(path: "/discover/movie", queryItems: [
            URLQueryItem(name: "primary_release_year", value: String(year)),
            URLQueryItem(name: "sort_by", value: sortBy),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: String(page))
        ])
    }
    
    static func getMovieDetailsRequest(movieID: Int, language: String = "en-US") -> URLRequest? {
        return makeRequest(path: "/movie/\(movieID)", queryItems: [
            URLQueryItem(name: "language", value: language)
        ])
    }
}
