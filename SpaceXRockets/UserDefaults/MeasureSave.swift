//
//  MeasureSave.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 05.11.2022.
//

import Foundation

enum MeasureSaveType: String {
    case isHeightChangedToFeet = "isHeightChangedToFeet"
    case isDiameterChangedToFeet = "isDiameterChangedToFeet"
    case isMassChangedToLB = "isMassChangedToLB"
    case isPayloadWeightsChangedToLB = "isPayloadWeightsChangedToLB"
}

final class MeasureSave {
    
    static let shared = MeasureSave()
    
    let userDefaults = UserDefaults.standard
    
    func setDefaultMeasure() {
        userDefaults.register(
            defaults: [
                MeasureSaveType.isHeightChangedToFeet.rawValue: false,
                MeasureSaveType.isDiameterChangedToFeet.rawValue: false,
                MeasureSaveType.isMassChangedToLB.rawValue: false,
                MeasureSaveType.isPayloadWeightsChangedToLB.rawValue: false
            ]
        )
    }
    
    private func setMeasure(with value: Bool, forKey key: MeasureSaveType) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func checkMeasure(forKey key: MeasureSaveType) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }
    
    func changeHeightMeasure() {
        if checkMeasure(forKey: .isHeightChangedToFeet) {
            setMeasure(with: false, forKey: .isHeightChangedToFeet)
        } else {
            setMeasure(with: true, forKey: .isHeightChangedToFeet)
        }
    }
    
    func changeDiameterMeasure() {
        if checkMeasure(forKey: .isDiameterChangedToFeet) {
            setMeasure(with: false, forKey: .isDiameterChangedToFeet)
        } else {
            setMeasure(with: true, forKey: .isDiameterChangedToFeet)
        }
    }
    
    func changeMassMeasure() {
        if checkMeasure(forKey: .isMassChangedToLB) {
            setMeasure(with: false, forKey: .isMassChangedToLB)
        } else {
            setMeasure(with: true, forKey: .isMassChangedToLB)
        }
    }
    
    func changePayLoadMeasure() {
        if checkMeasure(forKey: .isPayloadWeightsChangedToLB) {
            setMeasure(with: false, forKey: .isPayloadWeightsChangedToLB)
        } else {
            setMeasure(with: true, forKey: .isPayloadWeightsChangedToLB)
        }
    }
    
}
