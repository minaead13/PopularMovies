//
//  FavoritesLocalDataSource.swift
//  MoviesApp
//
//  Created by OSX on 10/07/2025.
//

import Foundation

protocol FavoritesLocalDataSource {
    func isFavorite(movieID: Int) -> Bool
    func toggleFavorite(movieID: Int)
}

class FavoritesLocalDataSourceImpl: FavoritesLocalDataSource {

    private let defaults = UserDefaults.standard
    private let key = "favorite_movies"
    
    func isFavorite(movieID: Int) -> Bool {
        let favorites = defaults.array(forKey: key) as? [Int] ?? []
        return favorites.contains(movieID)
    }
    
    func toggleFavorite(movieID: Int) {
        var favorites = defaults.array(forKey: key) as? [Int] ?? []
        if let index = favorites.firstIndex(of: movieID) {
            favorites.remove(at: index)
        } else {
            favorites.append(movieID)
        }
        defaults.set(favorites, forKey: key)
    }
}
