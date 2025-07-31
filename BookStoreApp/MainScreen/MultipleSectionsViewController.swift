//
//  MultipleSectionsViewController.swift
//  BookStoreApp
//
//  Created by Nazar on 30.07.2025.
//

import UIKit

final class MultipleSectionsViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    private let reuseIdentifier = "reuseIdentifier"
    private let colors: [UIColor] = [.systemTeal, .systemPurple, .systemCyan]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: -> Setup View
private extension MultipleSectionsViewController {
    func setup() {
        setupCollectionView()
        setupLayout()
    }
    
    func setupCollectionView() {
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: ElementKind.header,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
}

//MARK: -> Setup CollectionViewLayout
private extension MultipleSectionsViewController {
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 10
        
        return UICollectionViewCompositionalLayout(sectionProvider: { indexSection, _ in
            if indexSection == 0 {
                return self.createTopSection()
            } else if indexSection == 1 {
                return self.createMiddleSection()
            } else {
                return self.createBottomSection()
            }
            
        }, configuration: configuration)
    }
    
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //Header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: ElementKind.header,
            alignment: .top
        )
        
        return header
    }
    
    func createSize(
        itemWidth: NSCollectionLayoutDimension,
        itemsHeight: NSCollectionLayoutDimension,
        groupWidth: NSCollectionLayoutDimension,
        groupHeight: NSCollectionLayoutDimension,
        scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: itemWidth,
            heightDimension: itemsHeight
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: groupWidth,
            heightDimension: groupHeight
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = scrollingBehavior
            section.boundarySupplementaryItems = [createHeader()]
        
        return section
    }
    
    func createTopSection() -> NSCollectionLayoutSection {
        createSize(
            itemWidth: .absolute(100),
            itemsHeight: .absolute(100),
            groupWidth: .estimated(1),
            groupHeight: .estimated(1),
            scrollingBehavior: .continuous)
    }
    
    func createMiddleSection() -> NSCollectionLayoutSection{
        createSize(
            itemWidth: .absolute(150),
            itemsHeight: .absolute(190),
            groupWidth: .estimated(1),
            groupHeight: .estimated(1),
            scrollingBehavior: .continuous)
    }
    
    func createBottomSection() -> NSCollectionLayoutSection {
        createSize(
            itemWidth: .fractionalWidth(1),
            itemsHeight: .fractionalHeight(1),
            groupWidth: .fractionalWidth(1),
            groupHeight: .absolute(350),
            scrollingBehavior: .continuous)
    }
}

//MARK: -> Setup AutoLayout
private extension MultipleSectionsViewController {
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
extension MultipleSectionsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = colors[indexPath.section % colors.count]
        
        if indexPath.section == 0 {
            cell.layer.cornerRadius = cell.frame.width / 2
        } else {
            cell.layer.cornerRadius = 10
        }
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath)
    -> UICollectionReusableView {
        
        if kind == ElementKind.header {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as! SectionHeaderView
            header.configure(text: "Section \(indexPath.section + 1)")
            return header
        }
        return UICollectionReusableView()
    }
    
    
}
