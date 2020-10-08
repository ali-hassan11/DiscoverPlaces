//

import Foundation

protocol SearchCoordinatable {
    func pushDetailController(id: String, userLocation: LocationItem)
    func pushErrorController(message: String)
}
