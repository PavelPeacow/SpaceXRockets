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

struct APIConstant {
    static let rocketsURL = "https://api.spacexdata.com/v4/rockets"
    static let rocketFlightURL = "https://api.spacexdata.com/v4/launches/query"
}

final class APIManager {
    
    static let shared = APIManager()
    
    func getRockets(onCompletion: @escaping (Result<[RocketModel], APIError>) -> Void) {
        guard let url = URL(string: APIConstant.rocketsURL) else {
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
    
    func getRocketFlightHistory(rocketId: String, onCompletion: @escaping (Result<[RocketFlightModel], APIError>) -> Void) {
        guard let url = URL(string: APIConstant.rocketFlightURL) else {
            onCompletion(.failure(.wrongURL))
            return
        }
        
        let jsonParemeters: [String: Any] = [
              "query": [
                  "rocket": "\(rocketId)"
              ],
              "options": []
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonParemeters)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                onCompletion(.failure(.GetError))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(.DataWasNil))
                return
            }
            
            guard let result = try? JSONDecoder().decode(RocketFlightResult.self, from: data) else {
                onCompletion(.failure(.CantDecode))
                return
            }
            onCompletion(.success(result.docs ?? []))
        }
        task.resume()
    }
    
}
