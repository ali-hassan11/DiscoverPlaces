//

import Foundation
import CoreLocation
import MapKit

protocol NEWPlacesTabCoordinatable:  Coordinator, MyPlacesCoordinatable, SettingsPresentable, DetailCoordinatable {}

class NEWMyPlacesTabCoorinator: NEWPlacesTabCoordinatable {
    
    struct Dependencies {
        let defaultTypography: DefaultTypographyProvider
        let defaultTheming: DefaultThemingProvider
        let placeDetailsTypography: PlaceDetailTypographyProvider
        let placeDetailsTheming: PlaceDetailTheming
    }
    
    let dependencies: Dependencies
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let myPlacesController = MyPlacesViewController(coordinator: self)
        navigationController.pushViewController(myPlacesController, animated: true)
    }
 
    //MARK: - Settings
    func pushSettings() {
        let settingsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SettingsVCId") as UITableViewController
        navigationController.pushViewController(settingsController, animated: true)
    }
    
    //MARK: - MyPlaces & Detail
    func pushDetailController(id: String, userLocation: LocationItem) {
        let placeDetailViewModel = DetailsViewModel(coordinator: self, placeId: id, location: userLocation, typography: DefaultTypography(), theming: DefaultTheming())
        let newDetailsController = NEWPlaceDetailController(coordinator: self, viewModel: placeDetailViewModel)
        
        navigationController.pushViewController(newDetailsController, animated: true)
    }
    
    func pushErrorController(message: String) {
        let errorController = ErrorController(message: message, buttonTitle: Constants.okText, buttonHandler: popTwoControllers)
        navigationController.pushViewController(errorController, animated: true)
    }
 
    //MARK: - Detail
    func didTapPhoneNumber(number: String) {
        callNumber(number: number)
    }
    
    func openInMaps(place: PlaceDetailResult) {
        let lat = place.geometry.location.lat
        let long = place.geometry.location.lng
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
