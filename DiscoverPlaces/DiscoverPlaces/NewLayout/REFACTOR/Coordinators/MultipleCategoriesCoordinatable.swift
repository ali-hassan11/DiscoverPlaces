//

import Foundation

protocol MultipleCategoriesCoordinatable {
    func pushDetailController(id: String, userLocation: LocationItem)
    func pushErrorController(message: String)
}