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
        setupView()
        setupNavigationBar()
        setupCollectionView()
        setupLayout()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        
        navigationItem.title = "Поиск"
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupCollectionView() {
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
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
    
    func createSize(with params: SectionLayoutParameterss) -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: params.itemWidth,
            heightDimension: params.itemHeight
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: params.groupWidth,
            heightDimension: params.groupHeight
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createHeader()]
        
        return section
    }
    
    func createTopSection() -> NSCollectionLayoutSection {
        let params = SectionLayoutParameterss(
            itemWidth: .absolute(100),
            itemHeight: .absolute(100),
            
            groupWidth: .estimated(1),
            groupHeight: .estimated(1)
        )
        
        return createSize(with: params)
    }
    
    func createMiddleSection() -> NSCollectionLayoutSection{
        let params = SectionLayoutParameterss(
            itemWidth: .absolute(150),
            itemHeight: .absolute(190),
            
            groupWidth: .estimated(1),
            groupHeight: .estimated(1)
        )
        
        return createSize(with: params)
    }
    
    func createBottomSection() -> NSCollectionLayoutSection {
        let params = SectionLayoutParameterss(
            itemWidth: .fractionalWidth(1),
            itemHeight: .fractionalHeight(1),
            groupWidth: .fractionalWidth(1),
            groupHeight: .absolute(350)
        )
        
        return createSize(with: params)
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
}
