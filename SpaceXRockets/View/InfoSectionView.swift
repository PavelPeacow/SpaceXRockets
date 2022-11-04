//
//  StackviewTest.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 04.11.2022.
//

import UIKit

class InfoSectionView: UIView {
    
    private let firstSubtitle: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondSubtitle: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let thridSubtitle: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstSubtitleValue: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondSubtitleValue: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let thridSubtitleValue: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.spacing   = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackViewSecondColumnHorizontal: UIStackView = {
        let view = UIStackView()
        view.alignment = .trailing
        view.distribution  = .fillEqually
        view.axis = .vertical
        view.spacing   = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackViewMainContainerVertical)
        stackViewMainContainerVertical.addArrangedSubview(stackViewMainContainerHorizontal)
        
        stackViewMainContainerHorizontal.addArrangedSubview(stackViewFirstColumnHorizontal)
        stackViewMainContainerHorizontal.addArrangedSubview(stackViewSecondColumnHorizontal)

        stackViewFirstColumnHorizontal.addArrangedSubview(firstSubtitle)
        stackViewFirstColumnHorizontal.addArrangedSubview(secondSubtitle)
        stackViewFirstColumnHorizontal.addArrangedSubview(thridSubtitle)
        
        stackViewSecondColumnHorizontal.addArrangedSubview(firstSubtitleValue)
        stackViewSecondColumnHorizontal.addArrangedSubview(secondSubtitleValue)
        stackViewSecondColumnHorizontal.addArrangedSubview(thridSubtitleValue)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: RocketMainInformationViewModel) {
        
        if let title = model.title {
            sectionTitle.text = title
            stackViewMainContainerVertical.insertArrangedSubview(sectionTitle, at: 0)
        }
        
        firstSubtitle.text = model.firstSubtitle
        secondSubtitle.text = model.secondSubtitle
        thridSubtitle.text = model.thridSubtitle
        
        firstSubtitleValue.text = model.firstSubtitleValue
        secondSubtitleValue.text = model.secondSubtitleValue
        thridSubtitleValue.text = model.thridSubtitleValue
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMainContainerVertical.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            stackViewMainContainerVertical.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
        ])
    }
}
