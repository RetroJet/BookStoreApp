//
//  ViewController.swift
//  BookStoreApp
//
//  Created by Nazar on 24.07.2025.
//

import UIKit

final class CollectionViewController: UIViewController {
    var bookRepository: BookRepository!
    
    private var collectionView: UICollectionView!
    
    private let reuseIdentifier = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: -> Setup View
private extension CollectionViewController {
    func setup() {
        setupCollectionView()
        setupView()
        setupLayout()
    }
    
    func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
    }
    
    func setupCollectionView() {
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HorizontalScrollCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        
        collectionView.register(
            TitleView.self,
            forSupplementaryViewOfKind: ElementKind.title,
            withReuseIdentifier: TitleView.reuseIdentifier
        )
        
        collectionView.register(
            BadgeView.self,
            forSupplementaryViewOfKind: ElementKind.badge,
            withReuseIdentifier: BadgeView.reuseIdentifier
        )
        
        collectionView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        collectionView.dataSource = self
    }
}

//MARK: -> Setup CollectionViewLayout
private extension CollectionViewController {
    func createLayout() -> UICollectionViewLayout {
        let boundarySupplementaryItems = createBoundarySupplementaryItem()
        let supplementaryItems = createSupplementaryItem()
        let items = createItem(supplementaryItems: supplementaryItems)
        let groups = createGroup(items: items)
        let section = createSection(group: groups, boundaryItems: boundarySupplementaryItems)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createBoundarySupplementaryItem() -> [NSCollectionLayoutBoundarySupplementaryItem] {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return [header]
    }
    
    func createSupplementaryItem() -> [NSCollectionLayoutSupplementaryItem] {
        let badgeSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(20)
        )
        
        let badgeAnchor = NSCollectionLayoutAnchor(
            edges: [.top, .leading],
            absoluteOffset: CGPoint(x: 0, y: -20)
        )
        
        let badge = NSCollectionLayoutSupplementaryItem(
            layoutSize: badgeSize,
            elementKind: ElementKind.badge,
            containerAnchor: badgeAnchor
        )
        
        let titleSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(20)
        )
        
        let titleAnchor = NSCollectionLayoutAnchor(
            edges: [.bottom, .leading],
            absoluteOffset: CGPoint(x: 0, y: 30)
        )
        
        let title = NSCollectionLayoutSupplementaryItem(
            layoutSize: titleSize,
            elementKind: ElementKind.title,
            containerAnchor: titleAnchor
        )
        
        return [title, badge]
    }
    
    func createItem(supplementaryItems: [NSCollectionLayoutSupplementaryItem]) -> [NSCollectionLayoutItem] {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(0.8)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize,
            supplementaryItems: supplementaryItems
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        return [item]
    }
    
    func createGroup(items: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(190)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: items
        )
        
        group.contentInsets.top = 15
        
        return group
    }
    
    func createSection(
        group: NSCollectionLayoutGroup,
        boundaryItems: [NSCollectionLayoutBoundarySupplementaryItem]
    ) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
        section.boundarySupplementaryItems = boundaryItems
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

//MARK: -> Setup AutoLayout
private extension CollectionViewController {
    func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: -> UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        bookRepository.getBookTypes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookRepository.getBookTypes()[section].books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HorizontalScrollCell else {
            return UICollectionViewCell()
        }
        
        let book = bookRepository.getBookTypes()[indexPath.section].books[indexPath.item]
        
        cell.configure(with: book.image)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as! SectionHeaderView
            header.configure(
                text: bookRepository.getBookTypes()[indexPath.section].type)
            
            return header
            
        } else if kind == ElementKind.badge {
            let book = bookRepository.getBookTypes()[indexPath.section].books[indexPath.item]
            let badge = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: BadgeView.reuseIdentifier,
                for: indexPath
            ) as! BadgeView
            if book.isNew {
                badge.isHidden = false
                badge.configure(text: "Новинка")
            } else {
                badge.isHidden = true
            }
            
            return badge
            
        } else if kind == ElementKind.title {
            let titleView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleView.reuseIdentifier,
                for: indexPath) as! TitleView
            
            let book = bookRepository.getBookTypes()[indexPath.section].books[indexPath.item]
            titleView.configure(text: book.title)
            
            return titleView
        }
        return UICollectionReusableView()
    }
}
