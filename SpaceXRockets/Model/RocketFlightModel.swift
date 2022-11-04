//
//  RocketFlightModel.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 04.11.2022.
//

import Foundation

struct RocketFlightResult: Codable {
    let docs: [RocketFlightModel]?
}

struct RocketFlightModel: Codable {
    let name: String?
    let success: Bool?
    let date_utc: String?
}
