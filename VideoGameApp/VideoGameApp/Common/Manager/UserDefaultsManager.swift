//
//  UserDefaultsManager.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 23.01.2023.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {  }
    
    let favoritesKey: String = "GameFavoritesArray"
    
    func getGameFavorites() -> [Int] {
        UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }
    
    func addNewGameFavorite(id: Int) {
        var intArray = self.getGameFavorites()
        if !(intArray.contains(id)) {
            intArray.append(id)
        }
        UserDefaults.standard.set(intArray, forKey: favoritesKey)
    }
    
    func removeGameFavorite(id: Int) {
        var intArray = self.getGameFavorites()
        if (intArray.contains(id)) {
            let index = intArray.firstIndex(of: id)!
            intArray.remove(at: index)
        }
        UserDefaults.standard.set(intArray, forKey: favoritesKey)
    }
    
}
