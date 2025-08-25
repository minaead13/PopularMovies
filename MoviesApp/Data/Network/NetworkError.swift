//
//  NetworkError.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(String)
    case unknown
    
    var userMessage: String {
        switch self {
        case .invalidURL: return "Invalid request"
        case .decodingError: return "Data error"
        case .serverError(let msg): return msg
        case .unknown: return "Something went wrong"
        }
    }
}
