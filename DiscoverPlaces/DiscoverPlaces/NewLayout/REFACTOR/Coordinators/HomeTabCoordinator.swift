import UIKit

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get }
    
    func start()
    func pushPlaceDetail(id: String, userLocation: LocationItem)
    func pushSetLocationController(selectedLocationCompletion: @escaping ((Location, String?) -> Void), currentLocationCompletion: @escaping () -> Void)
//    func pushReviewDetail(review: Review)
}

class HomeTabCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    struct Dependencies {
        let defaultTypography: DefaultTypographyProvider
        let defaultTheming: DefaultThemingProvider
        let placeDetailsTypography: PlaceDetailTypographyProvider
        let placeDetailsTheming: PlaceDetailTheming
    }
    
    private let dependencies: Dependencies
    
    init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let homeController = HomeController(coordinator: self)
        navigationController.pushViewController(homeController, animated: true)
    }
    
    func pushPlaceDetail(id: String, userLocation: LocationItem) {
        let placeDetailViewModel = DetailsViewModel(placeId: id, location: userLocation, typography: DefaultTypography(), theming: DefaultTheming())
        let newDetailsController = NEWPlaceDetailController(viewModel: placeDetailViewModel)
        navigationController.pushViewController(newDetailsController, animated: true)
    }
    
    func pushSetLocationController(selectedLocationCompletion: @escaping ((Location, String?) -> Void), currentLocationCompletion: @escaping () -> Void) {
        
        let locationSearchController = LocationSearchController()
        
        locationSearchController.selectedLocationCompletionHandler = selectedLocationCompletion
        locationSearchController.determineUserLocationCompletionHandler = currentLocationCompletion
        
        navigationController.pushViewController(locationSearchController, animated: true)
    }
    
}
