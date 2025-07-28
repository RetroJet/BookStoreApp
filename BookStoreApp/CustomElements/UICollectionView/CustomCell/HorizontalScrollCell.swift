//
//  HorizontalScrollCell.swift
//  BookStoreApp
//
//  Created by Nazar on 24.07.2025.
//

import UIKit

class HorizontalScrollCell: UICollectionViewCell {
    private let imageCell = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: String) {
        imageCell.image = UIImage(named: image)
    }
}

//MARK: -> Setup View
private extension HorizontalScrollCell {
    func setup() {
        setupView()
        setupImage()
        setupLayout()
    }
    
    func setupView() {
        contentView.addSubview(imageCell)
    }
    
    func setupImage() {
        imageCell.contentMode = .scaleAspectFill
    }
    
    func setupLayout() {
        imageCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCell.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
}
