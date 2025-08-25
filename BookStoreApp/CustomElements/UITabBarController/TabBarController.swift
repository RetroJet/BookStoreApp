//
//  Untitled.swift
//  BookStoreApp
//
//  Created by Nazar on 24.08.2025.
//

import UIKit

enum TabBarItem {
    case home
    case search
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .search: return UIImage(systemName: "magnifyingglass")
        }
    }
    
    static let allTabBarItems = [home, search]
}

class TabBarController: UITabBarController {
    private let dataSource: [TabBarItem] = [.home, .search]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: -> Settings View
private extension TabBarController {
    func setup() {
        buildTabBarComponents()
        setupTapBar()
    }
    
    func buildTabBarComponents() {
        let bookManager: IBookManager = BookManager()
        
        if bookManager.isEmpty() {
            let bookRepository = BookRepository()
            let books = bookRepository.getBookTypes()
            bookManager.addBooks(books)
        }
        
        viewControllers = dataSource.map {
            switch $0 {
            case .home:
                let collectionVC = CollectionViewController(manager: bookManager)
                return UINavigationController(rootViewController: collectionVC)
            case .search:
                return UINavigationController(rootViewController: MultipleSectionsViewController()
                )
            }
        }
    }
    
    func setupTapBar() {
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        viewControllers?.enumerated().forEach { index, viewController in
            viewController.tabBarItem.title = dataSource[index].title
            viewController.tabBarItem.image = dataSource[index].icon
        }
    }
}
