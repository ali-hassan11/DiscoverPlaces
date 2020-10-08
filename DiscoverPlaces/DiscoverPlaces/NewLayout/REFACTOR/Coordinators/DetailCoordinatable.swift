//

import Foundation

protocol DetailCoordinatable: AnyObject {
    func openInMaps(place: PlaceDetailResult)
    func pushOpeningTimesController(openingHoursText: [String]?)
    func pushWebsiteController(webAddress: String?)
    func pushReviewController(review: Review)
    func pushDetailController(id: String, userLocation: LocationItem)
    func didTapPhoneNumber(number: String)
    func didTapShare(webAddress: String)
    func pushErrorController(message: String)
}
