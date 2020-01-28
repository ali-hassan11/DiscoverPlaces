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
            createNavController(viewController: DiscoverController(), title: "Discover"),
            createNavController(viewController: SearchController(), title: "Search")
        ]
        
    }

    fileprivate func createNavController(viewController: UIViewController, title: String, imageIconName: String? = nil) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .gray
        
        return navController
    }
}
