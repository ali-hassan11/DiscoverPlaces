//
//  BaseTabBarController.swift
//  DiscoverPlaces
//
//  Created by user on 26/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createNavController(viewController: HomeController(),
                                title: "Discover",
                                selectedImageName: "house.fill",
                                deselectedImageName: "house"),
            
            createNavController(viewController: SearchController(),
                                title: "Search",
                                selectedImageName: "magnifyingglass",
                                deselectedImageName: "magnifyingglass"),
            
            createNavController(viewController: MyPlacesViewController(),
                                title: "My Places",
                                selectedImageName: "person.fill",
                                deselectedImageName: "person")
        ]
        
        tabBar.tintColor = .systemPink
        
    }

    fileprivate func createNavController(viewController: UIViewController, title: String, selectedImageName: String, deselectedImageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        navController.tabBarItem.image = UIImage(systemName: deselectedImageName)

        navController.navigationBar.tintColor = UIColor.systemPink
        
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        
        return navController
    }
}
