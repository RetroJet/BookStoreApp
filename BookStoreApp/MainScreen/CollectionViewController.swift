import UIKit

final class CollectionViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var diffbleDataSource: UICollectionViewDiffableDataSource<BookType, Book>!
    
    private let reuseIdentifier = "reuseIdentifier"
    
    private let manager: IBookManager
    
    init(manager: IBookManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: -> Setup View
private extension CollectionViewController {
    func setup() {
        setupCollectionView()
        setupView()
        setupNavigationBar()
        configureDataSource()
        applyInitialData()
        setupLayout()
    }
    
    func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 30, weight: .bold)
        ]
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        let backItem = UIBarButtonItem()
        
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
        navigationItem.title = "Книги для души"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
        
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: -> UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = manager.getAllBooks()[indexPath.section].books[indexPath.item]
        
        let detailsVC = DetailsViewController()
        detailsVC.configure(book: book)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: -> UICollectionViewDiffableDataSource
private extension CollectionViewController {
    func configureDataSource() {
        diffbleDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: self.reuseIdentifier,
                for: indexPath) as? HorizontalScrollCell else {
                return UICollectionViewCell()
            }
            
            let book = self.manager.getAllBooks()[indexPath.section].books[indexPath.item]
            
            cell.configure(with: book.image)
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            
            return cell
        })
        
        diffbleDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                    for: indexPath
                ) as! SectionHeaderView
                let book = self.manager.getAllBooks()[indexPath.section].books[indexPath.item]
                header.configure(text: book.title)
                
                return header
                
            } else if kind == ElementKind.badge {
                let book = self.manager.getAllBooks()[indexPath.section].books[indexPath.item]
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
                
                let book = self.manager.getAllBooks()[indexPath.section].books[indexPath.item]
                titleView.configure(text: book.title)
                
                return titleView
            }
            return UICollectionReusableView()
        }
    }
    
    func applyInitialData() {
        var snapshot = NSDiffableDataSourceSnapshot<BookType, Book>()
        
        let sections = manager.getAllBooks()
        
        for bookType in sections {
            snapshot.appendSections([bookType])
            snapshot.appendItems(bookType.books, toSection: bookType)
        }
        
        diffbleDataSource.apply(snapshot, animatingDifferences: true)
    }
}
