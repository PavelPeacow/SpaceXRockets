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
    
    let height: [String : Double]
    let diameter: [String : Double]
    let mass: [String : Double]
    
    let first_flight: String
    let country: String
    let cost_per_launch: Int
    
    let first_stage: FirstStage
    let second_stage: SecondStage
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
