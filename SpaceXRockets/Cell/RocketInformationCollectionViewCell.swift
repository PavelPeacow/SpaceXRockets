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
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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
    
    func configure(with model: RocketHorizontalViewModel) {
        infoValue.text = model.value
        infoTitle.text = model.subtitle
    }
    
}

extension RocketInformationCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            infoValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            infoValue.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            infoTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            infoTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
