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
        scroll.backgroundColor = .orange
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
    
    private let rocketHorizontalCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 80)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .red
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(RocketInformationCollectionViewCell.self, forCellWithReuseIdentifier: RocketInformationCollectionViewCell.identifier)
        
        return collection
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
        container.addSubview(rocketHorizontalCollection)
        
        container.addSubview(infoSectionMain)
        container.addSubview(infoSectionFirstStage)
        container.addSubview(infoSectionSecondStage)
        container.addSubview(flightHistoryButton)
        
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
        
        present(vc, animated: true)
    }
    
    func configure(with model: RocketModel) {
        rocket = model
        
        rocketInfo.append(model.mass)
        rocketInfo.append(model.diameter)
        rocketInfo.append(model.height)
        
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
            
            rocketTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 25),
            rocketTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            
            rocketHorizontalCollection.topAnchor.constraint(equalTo: rocketTitle.bottomAnchor, constant: 15),
            rocketHorizontalCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rocketHorizontalCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rocketHorizontalCollection.heightAnchor.constraint(equalToConstant: 80),
            
            infoSectionMain.topAnchor.constraint(equalTo: rocketHorizontalCollection.bottomAnchor, constant: 25),
            infoSectionMain.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            infoSectionMain.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            infoSectionFirstStage.topAnchor.constraint(equalTo: infoSectionMain.bottomAnchor, constant: 25),
            infoSectionFirstStage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            infoSectionFirstStage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            infoSectionSecondStage.topAnchor.constraint(equalTo: infoSectionFirstStage.bottomAnchor, constant: 25),
            infoSectionSecondStage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            infoSectionSecondStage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),

            flightHistoryButton.topAnchor.constraint(equalTo: infoSectionSecondStage.bottomAnchor, constant: 30),
            flightHistoryButton.heightAnchor.constraint(equalToConstant: 45),
            flightHistoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flightHistoryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            flightHistoryButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
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
