//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Nazar on 24.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let collectionViewController = CollectionViewController()
        _ = MultipleSectionsViewController()
        let bookRepository = BookRepository()
        
        collectionViewController.bookRepository = bookRepository
        
        window?.rootViewController = collectionViewController
        window?.makeKeyAndVisible()
    }
}

