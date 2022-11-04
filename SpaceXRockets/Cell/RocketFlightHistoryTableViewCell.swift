//
//  RocketFlightHistoryTableViewCell.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 04.11.2022.
//

import UIKit

class RocketFlightHistoryTableViewCell: UICollectionViewCell {

    static let identifier = "RocketFlightHistoryTableViewCell"
    
    private let flightTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flightDate: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flightIconStatus: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(flightTitle)
        contentView.addSubview(flightDate)
        contentView.addSubview(flightIconStatus)
        
        contentView.layer.cornerRadius = 24

        contentView.backgroundColor = .systemGray3
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: RocketFlightHistoryViewModel) {
        flightTitle.text = model.name
        
        if let index = model.date_utc.range(of: "T")?.lowerBound {
            flightDate.text =  String(model.date_utc[..<index])
        }
       
        flightIconStatus.image = UIImage(named: model.success ? "success" : "failure")
    }
    
}

extension RocketFlightHistoryTableViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            flightTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            flightTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            flightDate.topAnchor.constraint(equalTo: flightTitle.bottomAnchor, constant: 0),
            flightDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            flightIconStatus.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34),
            flightIconStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            flightIconStatus.heightAnchor.constraint(equalToConstant: 32),
            flightIconStatus.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
}
