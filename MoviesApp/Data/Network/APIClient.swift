//
//  APIClient.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}
