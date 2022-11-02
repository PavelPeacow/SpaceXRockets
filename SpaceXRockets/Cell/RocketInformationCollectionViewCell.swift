//
//  RocketInformationCollectionViewCell.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 02.11.2022.
//

import UIKit

class RocketInformationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RocketInformationCollectionViewCell"
    
    private let infoValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(infoValue)
        contentView.addSubview(infoTitle)
        contentView.layer.cornerRadius = 25
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Double) {
        infoValue.text = String(model)
        infoTitle.text = String(model)
    }
    
}

extension RocketInformationCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            infoValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            infoValue.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            infoTitle.topAnchor.constraint(equalTo: infoValue.bottomAnchor, constant: 5),
            infoTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
