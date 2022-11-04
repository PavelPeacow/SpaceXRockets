//
//  RocketFlightHistoryViewController.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 04.11.2022.
//

import UIKit

class RocketFlightHistoryViewController: UIViewController {
    
    private var flightHistrory = [RocketFlightModel]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 300, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RocketFlightHistoryTableViewCell.self, forCellWithReuseIdentifier: RocketFlightHistoryTableViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)

        view.backgroundColor = .systemBackground
        
        setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func configure(with id: String) {
        getFlightHistory(with: id)
    }

}

extension RocketFlightHistoryViewController {
    
    func getFlightHistory(with id: String) {
        APIManager.shared.getRocketFlightHistory(rocketId: id) { [weak self] result in
            switch result {
            case .success(let success):
                self?.flightHistrory = success
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension RocketFlightHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        flightHistrory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketFlightHistoryTableViewCell.identifier, for: indexPath) as? RocketFlightHistoryTableViewCell else { return UICollectionViewCell() }
        
        let rocketFlightHistoryViewModel = RocketFlightHistoryViewModel(name: flightHistrory[indexPath.item].name ?? "tba", success: flightHistrory[indexPath.item].success ?? false, date_utc: flightHistrory[indexPath.item].date_utc ?? "tba")
        
        cell.configure(with: rocketFlightHistoryViewModel)
        
        return cell
    }
    

}
