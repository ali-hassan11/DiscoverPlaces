import UIKit

protocol HomeCoordinatable {
    func pushSetLocationController(selectedLocationCompletion: @escaping ((Location, String?) -> Void), locateUserCompletion: @escaping () -> Void)
    func pushDetailController(id: String, userLocation: LocationItem)
    func pushCategoriesController(category: Category, location: LocationItem)
    func pushNoResultsController(message: String, buttonTitle: String, buttonHandler: @escaping () -> Void)
}
