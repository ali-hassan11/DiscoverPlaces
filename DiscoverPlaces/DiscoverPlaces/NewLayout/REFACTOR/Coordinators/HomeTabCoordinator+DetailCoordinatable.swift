import Foundation
import CoreLocation
import MapKit

protocol DetailCoordinatable: AnyObject {
    func openInMaps(place: PlaceDetailResult)
    func pushOpeningTimesController()
    func pushWebsiteController()
    func pushReviewController()
    func pushDetailController()
    func didTapPhoneNumber()
    func didTapShare()
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
    
    func pushOpeningTimesController() {
        
    }
    
    func pushWebsiteController() {
        
    }
    
    func pushReviewController() {
        
    }
    
    func pushDetailController() {
        
    }
    
    func didTapPhoneNumber() {
        
    }
    
    func didTapShare() {
        
    }
    
}
