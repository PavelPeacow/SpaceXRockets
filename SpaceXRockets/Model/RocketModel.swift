//
//  RocketModel.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 02.11.2022.
//

import Foundation

struct RocketModel: Codable {
    let name: String
    let flickr_images: [String]
    
    let height: Height
    let diameter: Diameter
    let mass: Mass
    
    let first_flight: String
    let country: String
    let cost_per_launch: Int
    
    let first_stage: FirstStage
    let second_stage: SecondStage
}

struct Height: Codable {
    let meters: Double
    let feet: Double
}

struct Diameter: Codable {
    let meters: Double
    let feet: Double
}

struct Mass: Codable {
    let kg: Double
    let lb: Double
}

struct FirstStage: Codable {
    let engines: Int
    let fuel_amount_tons: Double
    let burn_time_sec: Int?
}

struct SecondStage: Codable {
    let engines: Int
    let fuel_amount_tons: Double
    let burn_time_sec: Int?
}
