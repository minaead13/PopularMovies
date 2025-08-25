//
//  NetworkService.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation
import Alamofire

class NetworkService: APIClient {
    
    func request<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        AF.request(request).validate().responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let decoded):
                completion(.success(decoded))
            case .failure(let error):
                if let data = response.data,
                   let serverMessage = String(data: data, encoding: .utf8) {
                    completion(.failure(.serverError(serverMessage)))
                } else {
                    completion(.failure(.serverError(error.localizedDescription)))
                }
            }
        }
    }
}
