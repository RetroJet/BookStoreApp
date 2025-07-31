//
//  Section.swift
//  BookStoreApp
//
//  Created by Nazar on 24.07.2025.
//

import UIKit

final class BadgeView: UICollectionReusableView {
    static let reuseIdentifier = "BadgeView"
    private let badgeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        badgeLabel.text = text
    }
}

//MARK: -> Setup View
private extension BadgeView {
    func setup() {
        setupView()
        setupLabel()
    }
    
    func setupView() {
        addSubview(badgeLabel)
    }
    
    func setupLabel() {
        badgeLabel.frame = bounds
        badgeLabel.backgroundColor = .systemPurple
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 5
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
