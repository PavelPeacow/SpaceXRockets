//
//  RocketSettingsViewController.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 04.11.2022.
//

import UIKit

class RocketSettingsViewController: UIViewController {
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let diameterLabel: UILabel = {
        let label = UILabel()
        label.text = "Diameter"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let massLabel: UILabel = {
        let label = UILabel()
        label.text = "Mass"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let payload: UILabel = {
        let label = UILabel()
        label.text = "Payload"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        return switchUI
    }()
    
    private let diameterSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        return switchUI
    }()
    
    private let massSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        return switchUI
    }()
    
    private let payloadSwitch: UISwitch = {
        let switchUI = UISwitch()
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
        view.distribution  = .fillProportionally
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
        stackViewMainContainerVertical.addArrangedSubview(stackViewMainContainerHorizontal)
        
        stackViewMainContainerHorizontal.addArrangedSubview(stackViewFirstColumnHorizontal)
        stackViewMainContainerHorizontal.addArrangedSubview(stackViewSecondColumnHorizontal)

        stackViewFirstColumnHorizontal.addArrangedSubview(heightLabel)
        stackViewFirstColumnHorizontal.addArrangedSubview(diameterLabel)
        stackViewFirstColumnHorizontal.addArrangedSubview(massLabel)
        stackViewFirstColumnHorizontal.addArrangedSubview(payload)
        
        stackViewSecondColumnHorizontal.addArrangedSubview(heightSwitch)
        stackViewSecondColumnHorizontal.addArrangedSubview(diameterSwitch)
        stackViewSecondColumnHorizontal.addArrangedSubview(massSwitch)
        stackViewSecondColumnHorizontal.addArrangedSubview(payloadSwitch)
        
        setConstraints()
        
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
