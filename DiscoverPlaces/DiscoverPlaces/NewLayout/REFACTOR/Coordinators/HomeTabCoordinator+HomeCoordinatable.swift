import UIKit

protocol HomeCoordinatable {
    func pushSetLocationController(selectedLocationCompletion: @escaping ((Location, String?) -> Void), locateUserCompletion: @escaping () -> Void)
    func pushDetailController(id: String, userLocation: LocationItem)
    func pushCategoriesController(category: Category, location: LocationItem)
    func pushNoResultsController(message: String, buttonTitle: String, buttonHandler: @escaping () -> Void)
    //PushNoError
}

//extension HomeTabCoordinator: HomeCoordinatable {
//
//    func pushSetLocationController(selectedLocationCompletion: @escaping ((Location, String?) -> Void), locateUserCompletion: @escaping () -> Void) {
//    
//        let locationSearchController = LocationSearchController(selctedLocationHandler: selectedLocationCompletion, locateUserHandler: locateUserCompletion)
//        
//        navigationController.pushViewController(locationSearchController, animated: true)
//    }
//    
//    func pushCategoriesController(category: Category, location: LocationItem) {
//        let multipleCategoriesController = MultipleCategoriesController(coordinator: self, category: category, location: location)
//        
//        navigationController.pushViewController(multipleCategoriesController, animated: true)
//    }
//    
//    func pushNoResultsController(message: String, buttonTitle: String, buttonHandler: @escaping () -> Void) {
//        let errorController = ErrorController(message: message, buttonTitle: buttonTitle, buttonHandler: buttonHandler)
//        
//        self.navigationController.pushViewController(errorController, animated: true)
//    }
//}
//
