//

import Foundation

protocol MyPlacesCoordinatable {
    func pushDetailController(id: String, userLocation: LocationItem)
    func pushErrorController(message: String)
}
