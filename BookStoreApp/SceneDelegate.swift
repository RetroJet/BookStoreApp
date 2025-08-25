//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Nazar on 24.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let allTabBarItems = TabBarItem.allTabBarItems
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = TabBarController()
        
        tabBarController.viewControllers?.enumerated().forEach { index, vc in
            guard let navVC = vc as? UINavigationController else { return }
            pushViewController(index: index, controller: navVC)
        }
        
        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    func pushViewController(index: Int, controller: UINavigationController) {
        let bookManager: IBookManager = BookManager()
        
        if bookManager.isEmpty() {
            let bookRepository = BookRepository()
            let books = bookRepository.getBookTypes()
            bookManager.addBooks(books)
        }
        
        switch allTabBarItems[index] {
        case .home:
            let collectionVC = CollectionViewController(manager: bookManager)
            controller.pushViewController(collectionVC, animated: false)
        case .search:
            controller.pushViewController(MultipleSectionsViewController(), animated: false)
        }
    }
}

