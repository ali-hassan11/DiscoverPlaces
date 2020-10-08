import Foundation

protocol CategoriesCoordinatable: AnyObject {
  
    func pushDetailController(id: String, userLocation: LocationItem)
    func pushErrorController(message: String)
}
//
//extension HomeTabCoordinator: CategoriesCoordinatable { }
