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
    var dataSource: [TabBarItem]?
    
    init(tabBarItems: [TabBarItem]?) {
        dataSource = tabBarItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            guard let dataSource else { return }
            
            viewControllers = dataSource.map {_ in
                let navigationController = UINavigationController()
                
                let appearance = UINavigationBarAppearance()
                
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
                
                appearance.titleTextAttributes = [
                    .foregroundColor: UIColor.white
                ]
                
                appearance.largeTitleTextAttributes = [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 30, weight: .bold)
                ]
                
                navigationController.navigationBar.standardAppearance = appearance
                navigationController.navigationBar.scrollEdgeAppearance = appearance
                
                return navigationController
                
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
                viewController.tabBarItem.title = dataSource?[index].title
                viewController.tabBarItem.image = dataSource?[index].icon
            }
        }
}
