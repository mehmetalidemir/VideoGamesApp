//
//  ListViewModel.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import Foundation

final class ListViewModel {
    
    var games: [Game] = []
    
    func fetchGames(didGetSuccessfully: @escaping (Bool) -> Void) {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let games):
                self.games = games.results
                didGetSuccessfully(true)
            case .failure(_):
                didGetSuccessfully(false)
            }
        }
    }
}
