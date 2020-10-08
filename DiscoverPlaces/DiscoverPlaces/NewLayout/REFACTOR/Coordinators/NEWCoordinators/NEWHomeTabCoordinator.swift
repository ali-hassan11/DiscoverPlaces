//
//  NEWHomeTabCoordinator.swift
//  DiscoverPlaces
//
//  Created by user on 08/10/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

protocol NEWHomeTabCoordinatable:  Coordinator, HomeCoordinatable, DetailCoordinatable {}

class NEWHomeTabCoordinator: NEWHomeTabCoordinatable {
    
    
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
        let homeController = HomeController(coordinator: self)
        navigationController.pushViewController(homeController, animated: true)
    }
    
    //MARK: - Home
    func pushSetLocationController(selectedLocationCompletion: @escaping ((Location, String?) -> Void), locateUserCompletion: @escaping () -> Void) {
    
        let locationSearchController = LocationSearchController(selctedLocationHandler: selectedLocationCompletion, locateUserHandler: locateUserCompletion)
        
        navigationController.pushViewController(locationSearchController, animated: true)
    }
    
    func pushCategoriesController(category: Category, location: LocationItem) {
        let multipleCategoriesController = MultipleCategoriesController(coordinator: self, category: category, location: location)
        
        navigationController.pushViewController(multipleCategoriesController, animated: true)
    }
    
    func pushNoResultsController(message: String, buttonTitle: String, buttonHandler: @escaping () -> Void) {
        let errorController = ErrorController(message: message, buttonTitle: buttonTitle, buttonHandler: buttonHandler)
        
        self.navigationController.pushViewController(errorController, animated: true)
    }
    
    //MARK: - Detail & Home
    func pushDetailController(id: String, userLocation: LocationItem) {
        let placeDetailViewModel = DetailsViewModel(coordinator: self, placeId: id, location: userLocation, typography: DefaultTypography(), theming: DefaultTheming())
        let newDetailsController = NEWPlaceDetailController(coordinator: self, viewModel: placeDetailViewModel)
        
        navigationController.pushViewController(newDetailsController, animated: true)
    }
    
    //MARK: - Detail
    func didTapPhoneNumber(number: String) {
        callNumber(number: number)
    }
    
    func pushErrorController(message: String) {
        let errorController = ErrorController(message: message, buttonTitle: Constants.okText, buttonHandler: popTwoControllers)
        navigationController.pushViewController(errorController, animated: true)
    }
    
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
