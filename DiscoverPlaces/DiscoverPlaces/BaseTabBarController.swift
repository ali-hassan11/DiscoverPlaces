
import UIKit

final class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Home
        let homeDependenceis = NEWHomeTabCoordinator.Dependencies(defaultTypography: DefaultTypography(),
                                                               defaultTheming: DefaultTheming(),
                                                               placeDetailsTypography: DefaultTypography(),
                                                               placeDetailsTheming: DefaultTheming())
        
        let homeTabCoordinator = NEWHomeTabCoordinator(navigationController: UINavigationController(), dependencies: homeDependenceis)
        homeTabCoordinator.start()
        
        
        //Search
        let searchDependenceis = NEWSearchTabCoordinator.Dependencies(defaultTypography: DefaultTypography(),
                                                               defaultTheming: DefaultTheming(),
                                                               placeDetailsTypography: DefaultTypography(),
                                                               placeDetailsTheming: DefaultTheming())
        
        let searchTabCoordinator = NEWSearchTabCoordinator(navigationController: UINavigationController(), dependencies: searchDependenceis)
        searchTabCoordinator.start()
        
        //MyPlaces
        let myPlacesDependenceis = NEWMyPlacesTabCoorinator.Dependencies(defaultTypography: DefaultTypography(),
                                                               defaultTheming: DefaultTheming(),
                                                               placeDetailsTypography: DefaultTypography(),
                                                               placeDetailsTheming: DefaultTheming())
        
        let myPlacesTabCoordinator = NEWMyPlacesTabCoorinator(navigationController: UINavigationController(), dependencies: myPlacesDependenceis)
        myPlacesTabCoordinator.start()
        
        viewControllers = [
            configureNavController(navController: homeTabCoordinator.navigationController,
                                   tabName: "Home",
                                   selectedImageName: "house.fill",
                                   deselectedImageName: "house"),
            
            configureNavController(navController: searchTabCoordinator.navigationController,
                                   tabName: "Search",
                                   selectedImageName: "magnifyingglass",
                                   deselectedImageName: "magnifyingglass"),
            
            configureNavController(navController: myPlacesTabCoordinator.navigationController,
                                   tabName: "My Places",
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
    
    private func configureNavController(navController: UINavigationController, tabName: String, selectedImageName: String, deselectedImageName: String) -> UIViewController {
        
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = tabName
        navController.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        navController.tabBarItem.image = UIImage(systemName: deselectedImageName)
        navController.navigationBar.tintColor = UIColor.systemPink
        
        return navController
    }
}

