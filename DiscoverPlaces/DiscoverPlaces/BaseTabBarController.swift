
import UIKit

final class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeDependenceis = HomeTabCoordinator.Dependencies(defaultTypography: DefaultTypography(),
                                                               defaultTheming: DefaultTheming(),
                                                               placeDetailsTypography: DefaultTypography(),
                                                               placeDetailsTheming: DefaultTheming())
        
        let homeCoordinator = HomeTabCoordinator(navigationController: UINavigationController(), dependencies: homeDependenceis)
        homeCoordinator.start()
        
        viewControllers = [
            configureNavController(navController: homeCoordinator.navigationController,
                                   title: "Home",
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
    
}

extension BaseTabBarController {
    
    private func createNavController(viewController: UIViewController, title: String, selectedImageName: String, deselectedImageName: String) -> UIViewController {
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
    
    private func configureNavController(navController: UINavigationController, title: String, selectedImageName: String, deselectedImageName: String) -> UIViewController {
        
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        navController.tabBarItem.image = UIImage(systemName: deselectedImageName)
        
        navController.navigationBar.tintColor = UIColor.systemPink
        
        return navController
    }
}

