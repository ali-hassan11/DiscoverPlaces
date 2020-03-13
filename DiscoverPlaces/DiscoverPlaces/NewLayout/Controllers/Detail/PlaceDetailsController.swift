//
//  DetailsViewController.swift
//  DiscoverPlaces
//
//  Created by user on 06/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit
import MapKit

class PlaceDetailsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {

    private enum Detail: Int {
        case address
        case openingHours
        case phoneNumber
        case website
        case actionButtons
        case reviews
        case morePlaces
    }
    
    var userLocation: Location?
    
    var morePlaces: [PlaceResult]?
    
    var placeId: String? {
        didSet {
            if let id = placeId {
                fetchPlaceData(for: id)
            }
        }
    }
    
    var place: PlaceDetailResult? {
        didSet {
            guard let location = place?.geometry?.location else { return }
            fetchMorePlacesData(near: location)
        }
    }
    
    let splashScreen: UIView! = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()

    fileprivate let errorCellId = "errorCellId"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .never
        navigationItem.largeTitleDisplayMode = .never
        
        setUpSplashScreen()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setUpSplashScreen() {

        self.view.addSubview(splashScreen)
        splashScreen.fillSuperview()
        
        let imagePlaceHolder = UIView()
        imagePlaceHolder.backgroundColor = .secondarySystemBackground
        splashScreen.addSubview(imagePlaceHolder)
        imagePlaceHolder.anchor(top: splashScreen.topAnchor, leading: splashScreen.leadingAnchor, bottom: nil, trailing: splashScreen.trailingAnchor)
        imagePlaceHolder.constrainHeight(constant: view.frame.height / 1.7)
    }
    
    private func registerCells() {
        //Header
        collectionView.register(PlaceImagesHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaceImagesHolder.id)
        
        collectionView.register(AddressCell.self, forCellWithReuseIdentifier: AddressCell.id)
        collectionView.register(OpeningTimeCell.self, forCellWithReuseIdentifier: OpeningTimeCell.id)
        collectionView.register(PhoneNumberCell.self, forCellWithReuseIdentifier: PhoneNumberCell.id)
        collectionView.register(WebAddressCell.self, forCellWithReuseIdentifier: WebAddressCell.id)
        collectionView.register(ActionButtonsCell.self, forCellWithReuseIdentifier: ActionButtonsCell.id)
        collectionView.register(ReviewsHolder.self, forCellWithReuseIdentifier: ReviewsHolder.id)
        collectionView.register(MorePlacesHolder.self, forCellWithReuseIdentifier: MorePlacesHolder.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: errorCellId)
    }
    
    private func fadeOutSplashScreen() {
        UIView.animate(withDuration: 0.2, animations: {
            self.splashScreen.alpha = 0
        }) { (true) in
            self.splashScreen.removeFromSuperview()
        }
    }
    
    func fetchPlaceData(for id: String) {
        let fields = ["name" , "place_id", "opening_hours", "photo", "vicinity" ,"geometry" ,"review" ,"website" ,"url" ,"international_phone_number", "formatted_phone_number" ,"formatted_address", "rating"]
        Service.shared.fetchPlaceDetails(placeId: id, fields: fields) { (placeResponse, error) in
            
            if let error = error {
                print("Falied to fetch: ", error)
                return
            }
            
            //success
            guard let placeResponse = placeResponse else {
                print("No results?")
                return
            }
            
            self.place = placeResponse.result
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.fadeOutSplashScreen()
            }
        }
    }
    
    func fetchMorePlacesData(near location: Location) {
        
        Service.shared.fetchNearbyPlaces(location: location, radius: 3000) { (results, error) in
            
            if let error = error {
                print("Failed to fetch places: ", error)
                return
            }
            
            //success
            guard let results = results else {
                print("No results?")
                return
            }
            
            var filteredResults = [PlaceResult]()
            
            results.results.forEach({ (result) in
                if result.containsPhotos() && result.types?.contains("point_of_interest") ?? true { //Exclude types???
                    filteredResults.append(result)
                }
            })
            
            self.morePlaces = filteredResults
            
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension PlaceDetailsController {
    
    //MARK: Place Images
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaceImagesHolder.id, for: indexPath) as! PlaceImagesHolder
        
        cell.pageControlView.numberOfPages = place?.photos?.count ?? 0
        cell.horizontalController.photos = place?.photos
        cell.placeName = place?.name
        cell.rating = place?.rating
        cell.horizontalController.didScrollImagesController = { nearestPage in
            cell.pageControlView.currentPage = nearestPage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height:  (view.frame.height / 2))
    }
    
    //MARK: Details
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            //Address
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddressCell.id, for: indexPath) as! AddressCell
            cell.vicinity = place?.vicinity
            return cell
        case 1:
            //Hours
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OpeningTimeCell.id, for: indexPath) as! OpeningTimeCell
            cell.openingTimes = place?.opening_hours?.weekdayText ?? []
            return cell
        case 2:
            //PhoneNumber
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoneNumberCell.id, for: indexPath) as! PhoneNumberCell
            cell.phoneNumber = place?.international_phone_number
            return cell
        case 3:
            //Website
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebAddressCell.id, for: indexPath) as! WebAddressCell
            cell.webAddress = place?.website
            return cell
        case 4:
            //ActionButtons
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionButtonsCell.id, for: indexPath) as! ActionButtonsCell
            cell.placeId = placeId
            cell.delegate = self
            return cell
        case 5:
            //Reviews
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsHolder.id, for: indexPath) as! ReviewsHolder
            cell.horizontalController.reviews = place?.reviews
            cell.horizontalController.didSelectHandler = { [weak self] review in
                let reviewViewController = ReviewDetailViewController()
                reviewViewController.review = review
                self?.navigationController?.show(reviewViewController, sender: self)
            }
            return cell
        case 6:
            //More Places
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MorePlacesHolder.id, for: indexPath) as! MorePlacesHolder
            cell.horizontalController.location = userLocation
            cell.horizontalController.places = morePlaces
            cell.horizontalController.didSelectPlaceInCategoriesHandler = { [weak self] id, name in
                let detailController = PlaceDetailsController()
                detailController.placeId = id
                self?.navigationController?.show(detailController, sender: self)
            }
            return cell
        default:
            #if DEBUG
            fatalError("Too many cells in section")
            #else
            let errorCell = collectionView.dequeueReusableCell(withReuseIdentifier: errorCellId, for: indexPath)
            return errorCell
            #endif
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return cellHeight(for: place?.vicinity, desiredHeight: 60)
        case 1:
            //Hours
            return cellHeight(for: place?.opening_hours, desiredHeight: 60)
        case 2:
            //PhoneNumber
            return cellHeight(for: place?.international_phone_number, desiredHeight: 60)
        case 3:
            //Website
            return cellHeight(for: place?.website, desiredHeight: 60)
        case 4:
            //ActionButtons
            return .init(width: view.frame.width, height: 60)
        case 5:
            //Reviews
            return cellHeight(for: place?.reviews, desiredHeight: 180)
        case 6:
            //More Places
            return .init(width: view.frame.width, height: 350 + 16)
        default:
            return .zero
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case Detail.address.rawValue:
            guard let place = place,
                let longitude = place.geometry?.location.lng,
                let latitude = place.geometry?.location.lat else { return }
            
            openInMaps(place: place, longitude: longitude, latitude: latitude)
            
        case Detail.openingHours.rawValue:
            let openingHoursController = OpeningHoursController()
            openingHoursController.openingHours = place?.opening_hours
            navigationController?.show(openingHoursController, sender: self)
            
        case Detail.website.rawValue:
            let websiteViewController = WebsiteViewController()
            websiteViewController.urlString = place?.website
            navigationController?.show(websiteViewController, sender: self)
            
        case Detail.phoneNumber.rawValue:
            guard let number = place?.international_phone_number else { return }
            callNumber(number: number)
            
        default:
            print("Other one pressed")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func cellHeight(for item: Any?, desiredHeight: CGFloat) -> CGSize {
        if item != nil {
            return .init(width: view.frame.width, height: desiredHeight)
        } else {
            return .zero
        }
    }
    
    private func openInMaps(place: PlaceDetailResult, longitude: Double, latitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude,longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = place.name
        mapItem.phoneNumber = place.international_phone_number
        if let urlString = place.website, let url = URL(string: urlString) {
            mapItem.url = url
        }
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func callNumber(number: String) {
        let number = number.trimmingCharacters(in: .whitespacesAndNewlines)
        makeCall(with: number)
    }
    
    func makeCall(with number: String) {
        
        if let url = URL(string: "tel://\(number)")  {
            UIApplication.shared.open(url)
        } else {
            UIPasteboard.general.string = number
            showToastAlert(title: "Copied to clipboard!")
        }
    }
}

extension PlaceDetailsController: ActionButtonsCellDelegate {
    
    func sharePressed(cell: ActionButtonsCell) {
        let urlString: String?
        
        if let websiteString = place?.website {
            urlString = websiteString
        } else if let googleMapsUrlString = place?.url {
            urlString = googleMapsUrlString
        } else {
            //Unable to retrieve info or something...
            return
        }
        
        guard let urlStr = urlString else { return }
        guard let url = URL(string: urlStr) else { return }
//        guard let name = place?.name else { return }
        
        let items: [Any] = [url]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true)
    }
    
}


