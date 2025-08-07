//
//  Section.swift
//  BookStoreApp
//
//  Created by Nazar on 28.07.2025.
//

import UIKit

final class TitleView: UICollectionReusableView {
    static let reuseIdentifier = "TitleSupplementaryView"
    
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        textLabel.text = text
    }
}

//MARK: -> Setup View
private extension TitleView {
    func setup() {
        setupView()
        setupLabel()
        setupLayout()
    }
    
    func setupView() {
        addSubview(textLabel)
    }
    
    func setupLabel() {
        textLabel.textColor = .white
        textLabel.font = .boldSystemFont(ofSize: 14)
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .left
    }
}

//MARK: -> Auto Layout
private extension TitleView {
    func setupLayout() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
