//
//  RocketSettingsViewController.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 04.11.2022.
//

import UIKit

protocol MeasureChangingProtocol {
    func didChangeMeasure()
}

class RocketSettingsViewController: UIViewController {
    
    var delegate: MeasureChangingProtocol?
    
    private let currentMeasureLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Measure"
        label.font = .boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let diameterLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let massLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let payloadLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var heightSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.addTarget(self, action: #selector(didTurnHeightSwitch), for: .valueChanged)
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        return switchUI
    }()
    
    private lazy var diameterSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.addTarget(self, action: #selector(didTurnDiameterSwitch), for: .valueChanged)
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        return switchUI
    }()
    
    private lazy var massSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.addTarget(self, action: #selector(didTurnMassSwitch), for: .valueChanged)
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        return switchUI
    }()
    
    private lazy var payloadSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.addTarget(self, action: #selector(didTurnPayloadsWeightsSwitch), for: .valueChanged)
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        return switchUI
    }()
    
    let stackViewMainContainerVertical: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution  = .equalCentering
        view.alignment = .fill
        view.spacing   = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let stackViewMainContainerHorizontal: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution  = .equalCentering
        view.axis = .horizontal
        view.spacing   = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackViewFirstColumnHorizontal: UIStackView = {
        let view = UIStackView()
        view.alignment = .leading
        view.distribution  = .fillEqually
        view.axis = .vertical
        view.spacing   = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackViewSecondColumnHorizontal: UIStackView = {
        let view = UIStackView()
        view.alignment = .trailing
        view.distribution  = .fillEqually
        view.axis = .vertical
        view.spacing   = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(stackViewMainContainerVertical)
        
        stackViewMainContainerVertical.addArrangedSubview(currentMeasureLabel)
        stackViewMainContainerVertical.addArrangedSubview(stackViewMainContainerHorizontal)
        
        
        stackViewMainContainerHorizontal.addArrangedSubview(stackViewFirstColumnHorizontal)
        stackViewMainContainerHorizontal.addArrangedSubview(stackViewSecondColumnHorizontal)

        
        stackViewFirstColumnHorizontal.addArrangedSubview(heightLabel)
        stackViewFirstColumnHorizontal.addArrangedSubview(diameterLabel)
        stackViewFirstColumnHorizontal.addArrangedSubview(massLabel)
        stackViewFirstColumnHorizontal.addArrangedSubview(payloadLabel)
        
        stackViewSecondColumnHorizontal.addArrangedSubview(heightSwitch)
        stackViewSecondColumnHorizontal.addArrangedSubview(diameterSwitch)
        stackViewSecondColumnHorizontal.addArrangedSubview(massSwitch)
        stackViewSecondColumnHorizontal.addArrangedSubview(payloadSwitch)
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAndTurnSwitch()
    }
    
    private func didTurnSwitch(switchUI: UISwitch, label: UILabel, textOn: String, textOff: String, forKey: MeasureSaveType) {
            if MeasureSave.shared.checkMeasure(forKey: forKey) {
                switchUI.isOn = true
                label.text = textOn
            } else {
                switchUI.isOn = false
                label.text = textOff
            }
    }
    
    private func checkAndTurnSwitch() {
        didTurnSwitch(switchUI: heightSwitch, label: heightLabel, textOn: "Height, feet", textOff: "Height, meters", forKey: .isHeightChangedToFeet)
        didTurnSwitch(switchUI: diameterSwitch, label: diameterLabel, textOn: "Diameter, feet", textOff: "Diameter, meters", forKey: .isDiameterChangedToFeet)
        didTurnSwitch(switchUI: massSwitch, label: massLabel, textOn: "Mass, lb", textOff: "Mass, kg", forKey: .isMassChangedToLB)
        didTurnSwitch(switchUI: payloadSwitch, label: payloadLabel, textOn: "Payload, lb", textOff: "Payload, kg", forKey: .isPayloadWeightsChangedToLB)
    }
    
    @objc private func didTurnHeightSwitch() {
        MeasureSave.shared.changeHeightMeasure()
        didTurnSwitch(switchUI: heightSwitch, label: heightLabel, textOn: "Height, feet", textOff: "Height, meters", forKey: .isHeightChangedToFeet)
        delegate?.didChangeMeasure()
    }
    
    @objc private func didTurnDiameterSwitch() {
        MeasureSave.shared.changeDiameterMeasure()
        didTurnSwitch(switchUI: diameterSwitch, label: diameterLabel, textOn: "Diameter, feet", textOff: "Diameter, meters", forKey: .isDiameterChangedToFeet)
        delegate?.didChangeMeasure()
    }
    
    @objc private func didTurnMassSwitch() {
        MeasureSave.shared.changeMassMeasure()
        didTurnSwitch(switchUI: massSwitch, label: massLabel, textOn: "Mass, lb", textOff: "Height, kg", forKey: .isMassChangedToLB)
        delegate?.didChangeMeasure()
    }
    
    @objc private func didTurnPayloadsWeightsSwitch() {
        MeasureSave.shared.changePayLoadMeasure()
        didTurnSwitch(switchUI: payloadSwitch, label: payloadLabel, textOn: "Payload, lb", textOff: "Payload, kg", forKey: .isPayloadWeightsChangedToLB)
        delegate?.didChangeMeasure()
    }
    
}

extension RocketSettingsViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMainContainerVertical.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            stackViewMainContainerVertical.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            stackViewMainContainerVertical.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
        ])
    }
}
