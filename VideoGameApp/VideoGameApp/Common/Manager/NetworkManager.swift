//
//  NetworkManager.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {  }
    
    func fetchData(completionHandler: @escaping (Result<GameResponse,NetworkError>) -> Void) {
        if InternetReachabilityManager.shared.isInternetActive() {
            guard let url = URL(string: "\(APIConstants.baseAPI)\(APIConstants.gameEndpoint)\(APIConstants.apiKey)") else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(GameResponse.self, from: data)
                        completionHandler(.success(decodedData))
                    } catch {
                        completionHandler(.failure(NetworkError.decodingError))
                    }
                    
                } else {
                    completionHandler(.failure(NetworkError.networkError))
                }
            }.resume()
        } else {
        }
        
    }
}

enum NetworkError: Error {
    case decodingError
    case networkError
}
