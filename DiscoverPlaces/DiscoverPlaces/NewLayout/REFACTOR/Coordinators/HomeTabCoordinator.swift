import UIKit

import UIKit

class HomeTabCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    struct Dependencies {
        let defaultTypography: DefaultTypographyProvider
        let defaultTheming: DefaultThemingProvider
        let placeDetailsTypography: PlaceDetailTypographyProvider
        let placeDetailsTheming: PlaceDetailTheming
    }
    
    let dependencies: Dependencies
    
    init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let homeController = HomeController(coordinator: self)
        navigationController.pushViewController(homeController, animated: true)
    }
}

