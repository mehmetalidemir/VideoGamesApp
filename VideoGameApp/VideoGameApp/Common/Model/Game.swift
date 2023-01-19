//
//  Game.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import Foundation

struct GameResponse: Codable {
    let results: [Game]
}
struct Game: Codable {
    let id: Int
    let name: String
    let released: String
    let background_image: String
    let rating: Double
    let reviews_count: Int
    let platforms: [GamePlatforms]
    let genres: [GameGenres]
}

struct GamePlatforms: Codable {
    let platform: GamePlatform
}

struct GamePlatform: Codable {
    let name: String
}

struct GameGenres: Codable {
    let name: String
}
