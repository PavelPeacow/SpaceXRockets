//
//  ViewController.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 02.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var rockets = [RocketModel]()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(rocketImage)
        
        view.addSubview(container)
        container.addSubview(rocketTitle)
        container.addSubview(rocketHorizontalCollection)
        
        getRockets()
        
        setDelegates()
        setConstraints()
    }
    
    private func setDelegates() {
        rocketHorizontalCollection.delegate = self
        rocketHorizontalCollection.dataSource = self
    }

}

extension ViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            rocketImage.topAnchor.constraint(equalTo: view.topAnchor),
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
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketInformationCollectionViewCell.identifier, for: indexPath) as? RocketInformationCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: (rockets.first?.diameter.first!.value) ?? 0)
        return cell
    }
}

extension ViewController {
    
    func getRockets() {
        APIManager.shared.getRockets { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.rockets = success
                    self?.rocketImage.image = UIImage(named: "img")
                    self?.rocketTitle.text = self?.rockets.first?.name
                    self?.getRocketImage(by: self?.rockets.first?.flickr_images.randomElement() ?? "")
                    self?.rocketHorizontalCollection.reloadData()
                    print(self?.rockets as Any)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
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
