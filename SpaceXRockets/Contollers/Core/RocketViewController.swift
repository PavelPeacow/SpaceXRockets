//
//  ViewController.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 02.11.2022.
//

import UIKit

class RocketViewController: UIViewController {
    
    private var rocket: RocketModel!
    private var rocketInfo = [Any]()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let rocketImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rocketTitle: UILabel = {
        let title = UILabel()
        title.text = "Placeholder"
        title.font = .systemFont(ofSize: 30, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        let image = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "gearshape.fill", withConfiguration: image)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        return button
    }()
    
    private let rocketHorizontalCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 96, height: 96)
        layout.minimumLineSpacing = 12
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(RocketInformationCollectionViewCell.self, forCellWithReuseIdentifier: RocketInformationCollectionViewCell.identifier)
        
        return collection
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoSectionMain, infoSectionFirstStage, infoSectionSecondStage, flightHistoryButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()
    
    private let infoSectionMain: InfoSectionView = {
        let section = InfoSectionView()
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    private let infoSectionFirstStage: InfoSectionView = {
        let section = InfoSectionView()
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    private let infoSectionSecondStage: InfoSectionView = {
        let section = InfoSectionView()
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    private lazy var flightHistoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Flight History", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapFlightHistoryButton), for: .touchUpInside)
        button.backgroundColor = .systemGray4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(rocketImage)
        
        scrollView.addSubview(container)
        container.addSubview(rocketTitle)
        container.addSubview(settingsButton)
        container.addSubview(rocketHorizontalCollection)
        
        container.addSubview(mainStackView)
        
        setDelegates()
        setConstraints()
    }
    
    private func setDelegates() {
        rocketHorizontalCollection.delegate = self
        rocketHorizontalCollection.dataSource = self
    }
    
    @objc private func didTapFlightHistoryButton() {
        let vc = RocketFlightHistoryViewController()
        vc.configure(with: rocket.id)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapSettingsButton() {
        let vc = RocketSettingsViewController()
        
        present(vc, animated: true)
    }
    
    func configure(with model: RocketModel) {
        rocket = model
        
        rocketInfo.append(model.mass)
        rocketInfo.append(model.diameter)
        rocketInfo.append(model.height)
        rocketInfo.append(model.payload_weights.first ?? "tba")
        
        configureMainInfoSection(with: model)
        configureFirstStageSection(with: model)
        configureSecondStageSection(with: model)
        
        rocketTitle.text = model.name
        getRocketImage(by: model.flickr_images.randomElement() ?? "")
    }
    
    private func configureMainInfoSection(with model: RocketModel) {
        let rocketMainInformation = RocketMainInformationViewModel(title: nil,
                                                                   firstSubtitle: "First Flight",
                                                                   firstSubtitleValue: model.first_flight,
                                                                   secondSubtitle: "Country", secondSubtitleValue: model.country,
                                                                   thridSubtitle: "Launch Cost",
                                                                   thridSubtitleValue: String(model.cost_per_launch))
        
        infoSectionMain.configure(with: rocketMainInformation)
    }
    
    private func configureFirstStageSection(with model: RocketModel) {
        let rocketMainInformation = RocketMainInformationViewModel(title: "First Stage",
                                                                   firstSubtitle: "Number of Engines",
                                                                   firstSubtitleValue: String(model.first_stage.engines),
                                                                   secondSubtitle: "Quantity of Fuel", secondSubtitleValue: String(model.first_stage.fuel_amount_tons),
                                                                   thridSubtitle: "Burn Time",
                                                                   thridSubtitleValue: String(model.first_stage.burn_time_sec ?? 0))
        
        infoSectionFirstStage.configure(with: rocketMainInformation)
    }
    
    private func configureSecondStageSection(with model: RocketModel) {
        let rocketMainInformation = RocketMainInformationViewModel(title: "Second Stage",
                                                                   firstSubtitle: "Number of Engines",
                                                                   firstSubtitleValue: String(model.second_stage.engines),
                                                                   secondSubtitle: "Quantity of Fuel", secondSubtitleValue: String(model.second_stage.fuel_amount_tons),
                                                                   thridSubtitle: "Burn Time",
                                                                   thridSubtitleValue: String(model.second_stage.burn_time_sec ?? 0))
        
        infoSectionSecondStage.configure(with: rocketMainInformation)
    }
    
}

extension RocketViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rocketImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rocketImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rocketImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3.5),
            
            container.topAnchor.constraint(equalTo: rocketImage.bottomAnchor, constant: -5),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rocketTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 48),
            rocketTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32),
            
            settingsButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 48),
            settingsButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32),
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
            settingsButton.widthAnchor.constraint(equalToConstant: 32),
            
            rocketHorizontalCollection.topAnchor.constraint(equalTo: rocketTitle.bottomAnchor, constant: 32),
            rocketHorizontalCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            rocketHorizontalCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rocketHorizontalCollection.heightAnchor.constraint(equalToConstant: 96),
            
            mainStackView.topAnchor.constraint(equalTo: rocketHorizontalCollection.bottomAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
}

extension RocketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rocketInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketInformationCollectionViewCell.identifier, for: indexPath) as? RocketInformationCollectionViewCell else { return UICollectionViewCell() }
        
        let value = rocketInfo[indexPath.item]
        let rocketViewModel: RocketHorizontalViewModel
        
        
        if let item = value as? Height {
            rocketViewModel = RocketHorizontalViewModel(value: String(item.meters), subtitle: "Height")
            cell.configure(with: rocketViewModel)
        } else if let item = value as? Diameter {
            rocketViewModel = RocketHorizontalViewModel(value: String(item.meters), subtitle: "Diameter")
            cell.configure(with: rocketViewModel)
        } else if let item = value as? Mass {
            rocketViewModel = RocketHorizontalViewModel(value: String(item.kg), subtitle: "Mass")
            cell.configure(with: rocketViewModel)
        } else if let item = value as? PayloadWeights {
            rocketViewModel = RocketHorizontalViewModel(value: String(item.kg), subtitle: "Playload")
            cell.configure(with: rocketViewModel)
        }
        
        return cell
    }
}

extension RocketViewController {
    
    func getRocketImage(by url: String) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self?.rocketImage.image = UIImage(data: data)
            }
        }
        
    }
}
