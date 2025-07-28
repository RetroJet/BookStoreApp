//
//  SectionHeader.swift
//  BookStoreApp
//
//  Created by Nazar on 24.07.2025.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        label.text = text
    }
}

//MARK: Setup View
private extension SectionHeaderView {
    func setup() {
        setupLabel()
        setupView()
        setupLayout()
    }
    
    func setupView() {
        addSubview(label)
    }
    
    func setupLabel() {
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
    }
}

//MARK: -> Setup AutoLayout
private extension SectionHeaderView {
    func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
