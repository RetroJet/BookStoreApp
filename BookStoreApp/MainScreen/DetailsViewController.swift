//
//  Untitled.swift
//  BookStoreApp
//
//  Created by Nazar on 06.08.2025.
//

import UIKit

final class DetailsViewController: UIViewController {
    private let heartButton = UIButton()
    private let bookImage = UIImageView()
    private let bookTitle = UILabel()
    
    private var isLiked = false
    
    override func viewDidLoad() {
        setup()
    }
    
    func configure(book: Book?) {
        bookImage.image = UIImage(named: book?.image ?? "")
        bookTitle.text = book?.title
    }
    
    @objc
    private func heartTapped() {
        isLiked.toggle()
        
        let imageName = isLiked ? "heart.fill" : "heart"
        let color = isLiked ? UIColor.systemRed : UIColor.white
        
        heartButton.setImage(UIImage(systemName: imageName), for: .normal)
        heartButton.tintColor = color
    }
}

private extension DetailsViewController {
    func setup() {
        setupView()
        setNavigationBar()
        setupButton()
        setupLabel()
        setupLayout()
    }
    
    func setupView() {
        view.addSubviews(
            bookImage,
            bookTitle
        )
        
        view.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
    }
    
    func setNavigationBar() {
        navigationItem.title = "Book"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: heartButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupButton() {
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .white
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        heartButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        heartButton.addTarget(
            self,
            action: #selector(heartTapped),
            for: .touchUpInside
        )
    }
    
    func setupLabel() {
        bookTitle.textColor = .white
        bookTitle.font = .boldSystemFont(ofSize: 20)
        bookTitle.numberOfLines = 2
        bookTitle.textAlignment = .center
    }
}

private extension DetailsViewController {
    func setupLayout() {
        [bookImage, bookTitle, heartButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                bookImage.widthAnchor.constraint(equalToConstant: 250),
                bookImage.heightAnchor.constraint(equalToConstant: 250),
                bookImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
                bookImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                bookTitle.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 15),
                bookTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        }
    }
}
