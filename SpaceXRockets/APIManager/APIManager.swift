//
//  APIManager.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 02.11.2022.
//

import Foundation

enum APIError: Error {
    case wrongURL
    case GetError
    case DataWasNil
    case CantDecode
}


final class APIManager {
    
    static let shared = APIManager()
    
    private let rocketsURL = "https://api.spacexdata.com/v4/rockets"
    
    func getRockets(onCompletion: @escaping (Result<[RocketModel], APIError>) -> Void) {
        guard let url = URL(string: rocketsURL) else {
            onCompletion(.failure(.wrongURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard error == nil else {
                onCompletion(.failure(.GetError))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(.DataWasNil))
                return
            }
            
            guard let result = try? JSONDecoder().decode([RocketModel].self, from: data) else {
                onCompletion(.failure(.CantDecode))
                return
            }
            onCompletion(.success(result))
        }
        task.resume()
    }
    
}
