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
    
    func pushDetailController(id: String, userLocation: LocationItem) {
        let placeDetailViewModel = DetailsViewModel(delegate: self, placeId: id, location: userLocation, typography: DefaultTypography(), theming: DefaultTheming())
        let newDetailsController = NEWPlaceDetailController(coordinator: self, viewModel: placeDetailViewModel)
        
        navigationController.pushViewController(newDetailsController, animated: true)
    }
    
    func pushErrorController(message: String) {
        let errorController = ErrorController(message: message, buttonTitle: Constants.okText, buttonHandler: popTwoControllers)
        navigationController.pushViewController(errorController, animated: true)
    }
}

extension HomeTabCoordinator {
    func popTwoControllers() -> Void {
        let viewControllers = navigationController.viewControllers
        navigationController.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
