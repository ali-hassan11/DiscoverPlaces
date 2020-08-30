import Foundation
import CoreLocation
import MapKit

protocol DetailCoordinatable: AnyObject {
    func openInMaps(place: PlaceDetailResult)
    func pushOpeningTimesController(openingHoursText: [String]?)
    func pushWebsiteController(webAddress: String?)
    func pushReviewController(review: Review)
    func pushDetailController(id: String, userLocation: LocationItem)
    func didTapPhoneNumber(number: String)
    func didTapShare(webAddress: String)
    func pushErrorController(message: String)
    //func didTapFave & To-Do???
}

extension HomeTabCoordinator: DetailCoordinatable {

    func openInMaps(place: PlaceDetailResult) {
        guard let lat = place.geometry?.location.lat, let long = place.geometry?.location.lng else { return }
        let coordinate = CLLocationCoordinate2DMake(lat,long)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = place.name
        mapItem.phoneNumber = place.international_phone_number
        if let urlString = place.website, let url = URL(string: urlString) {
            mapItem.url = url
        }
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func pushOpeningTimesController(openingHoursText: [String]?) {
        guard let openingHoursText = openingHoursText else { return }
        let openingHoursController = OpeningHoursController(openingHours: openingHoursText)
        navigationController.show(openingHoursController, sender: self)
    }
    
    func didTapPhoneNumber(number: String) {
        callNumber(number: number)
    }
    
    func pushWebsiteController(webAddress: String?) {
        guard let webAddress = webAddress else { return }
        let websiteViewController = WebsiteViewController(webAddress: webAddress)
        websiteViewController.webAddress = webAddress
        navigationController.show(websiteViewController, sender: self)
    }
    
    func didTapShare(webAddress: String) {
        
        guard let url = URL(string: webAddress) else { return }
        
        let items: [Any] = [url]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        navigationController.visibleViewController?.present(activityController, animated: true)
    }
    
    func pushReviewController(review: Review) {
        let reviewViewController = ReviewDetailViewController()
        reviewViewController.review = review
        navigationController.show(reviewViewController, sender: self)
    }
}

private extension HomeTabCoordinator {
    
    func callNumber(number: String) {
        
        let number = number.trimmingCharacters(in: .whitespacesAndNewlines)
        makeCall(with: number)
    }
    
    func makeCall(with number: String) {
        
        if let url = URL(string: "tel://\(number)")  {
            UIApplication.shared.open(url)
        } else {
            UIPasteboard.general.string = number
            navigationController.visibleViewController?.showToastAlert(title: "Number copied to clipboard!")
        }
    }
}
