import UIKit

protocol HomeCoordinatable {
    func pushPlaceDetail(id: String, userLocation: LocationItem)
    func pushSetLocationController(selectedLocationCompletion: @escaping ((Location, String?) -> Void), locateUserCompletion: @escaping () -> Void)
    func pushCategoriesController(category: Category, location: LocationItem)
    func pushNoResultsController(message: String, buttonTitle: String, buttonHandler: @escaping () -> Void)
}

extension HomeTabCoordinator: HomeCoordinatable {

    func pushSetLocationController(selectedLocationCompletion: @escaping ((Location, String?) -> Void), locateUserCompletion: @escaping () -> Void) {
        
        let locationSearchController = LocationSearchController(selctedLocationHandler: selectedLocationCompletion, locateUserHandler: locateUserCompletion)
        
        navigationController.pushViewController(locationSearchController, animated: true)
    }
    
    func pushPlaceDetail(id: String, userLocation: LocationItem) {
        let placeDetailViewModel = DetailsViewModel(delegate: self, placeId: id, location: userLocation, typography: DefaultTypography(), theming: DefaultTheming())
        let newDetailsController = NEWPlaceDetailController(viewModel: placeDetailViewModel)
        
        navigationController.pushViewController(newDetailsController, animated: true)
    }
    
    func pushCategoriesController(category: Category, location: LocationItem) {
        let multipleCategoriesController = MultipleCategoriesController(category: category, location: location)
        
        navigationController.pushViewController(multipleCategoriesController, animated: true)
    }
    
    func pushNoResultsController(message: String, buttonTitle: String, buttonHandler: @escaping () -> Void) {
        let errorController = ErrorController(message: message, buttonTitle: buttonTitle, buttonHandler: buttonHandler)
        
        self.navigationController.pushViewController(errorController, animated: true)
    }
    
}

