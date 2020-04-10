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
        case googleCell
    }
    
    let searchResponseFilter = SearchResponseFilter()

    private let location: LocationItem
    private let placeId: String

    var placeDetailResult: PlaceDetailResult?
    var morePlaces: [PlaceResult]?

    let splashScreen: UIView! = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .medium)
        aiv.color = .secondaryLabel
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()

    fileprivate let errorCellId = "errorCellId"
    
    init(placeId: String, location: LocationItem) {
        self.placeId = placeId
        self.location = location
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setUpSplashScreen()
        setupCollectionView()
        registerCells()
        setIndexForImagesHolderSegmentControl(to: 0)
        
        fetchPlaceData(for: placeId)
    }
    
    private func setIndexForImagesHolderSegmentControl(to segment: Int) {
        UserDefaults.standard.set(segment, forKey: "nearestPageKey")
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
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setUpSplashScreen() {

        self.view.addSubview(splashScreen)
        splashScreen.fillSuperview()
        
        let imagePlaceHolder = UIView()
        imagePlaceHolder.backgroundColor = .secondarySystemBackground
        splashScreen.addSubview(imagePlaceHolder)
        imagePlaceHolder.anchor(top: splashScreen.topAnchor, leading: splashScreen.leadingAnchor, bottom: nil, trailing: splashScreen.trailingAnchor)
        imagePlaceHolder.constrainHeight(constant: view.frame.height / 2)
        
        imagePlaceHolder.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
    }
    
    private func registerCells() {
        collectionView.register(PlaceImagesHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaceImagesHolder.id)
        
        collectionView.register(AddressCell.self, forCellWithReuseIdentifier: AddressCell.id)
        collectionView.register(OpeningTimeCell.self, forCellWithReuseIdentifier: OpeningTimeCell.id)
        collectionView.register(PhoneNumberCell.self, forCellWithReuseIdentifier: PhoneNumberCell.id)
        collectionView.register(WebAddressCell.self, forCellWithReuseIdentifier: WebAddressCell.id)
        collectionView.register(ActionButtonsCell.self, forCellWithReuseIdentifier: ActionButtonsCell.id)
        collectionView.register(ReviewsHolder.self, forCellWithReuseIdentifier: ReviewsHolder.id)
        collectionView.register(MorePlacesHolder.self, forCellWithReuseIdentifier: MorePlacesHolder.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: errorCellId)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.id)
    }
    
    private func fadeOutSplashScreen() {
        UIView.animate(withDuration: 0.2, animations: {
            self.splashScreen.alpha = 0
            self.activityIndicatorView.alpha = 0
        }) { (true) in
            self.splashScreen.removeFromSuperview()
            self.activityIndicatorView.removeFromSuperview()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
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
            
            guard let detailResult = placeResponse.result else { return }
            self.handlePlaceDetailSuccess(with: detailResult)
        }
    }
    
    private func handlePlaceDetailSuccess(with result: PlaceDetailResult) {
        self.placeDetailResult = result
        guard let location = result.geometry?.location else { return }
        self.fetchMorePlacesData(near: location)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.fadeOutSplashScreen()
        }
    }
    
    func fetchMorePlacesData(near location: Location) {
        
        Service.shared.fetchNearbyPlaces(location: location, radius: 3000) { (response, error) in
            
            if let error = error {
                print("Failed to fetch places: ", error)
                return
            }
            
            //success
            guard let response = response else {
                print("No results?")
                return
            }
                        
            let filteredResults = self.searchResponseFilter.morePlacesResults(from: response)
            self.handleMorePlacesSuccess(with: filteredResults)
        }
    }
    
    private func handleMorePlacesSuccess(with results: [PlaceResult]) {
        self.morePlaces = remove(currentPlaceId: placeId, from: results)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func remove(currentPlaceId: String, from places: [PlaceResult]) -> [PlaceResult] {
        return places.filter{$0.place_id != currentPlaceId}
    }
    
}

extension PlaceDetailsController {
    
    //MARK: Place Images
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaceImagesHolder.id, for: indexPath) as! PlaceImagesHolder
        guard let placeDetail = placeDetailResult else { return cell }
        cell.configure(using: placeDetail, actualLocation: location.actualUserLocation)
        cell.horizontalController.didScrollImagesController = { nearestPage in
            cell.segmentedControl.selectedSegmentIndex = nearestPage
            self.setIndexForImagesHolderSegmentControl(to: nearestPage)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height:  (view.frame.height / 2))
    }
    
    //MARK: Details
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case Detail.address.rawValue:

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddressCell.id, for: indexPath) as! AddressCell
            cell.vicinity = placeDetailResult?.vicinity
            return cell
            
        case Detail.openingHours.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OpeningTimeCell.id, for: indexPath) as! OpeningTimeCell
            cell.openingTimes = placeDetailResult?.opening_hours?.weekdayText ?? []
            return cell
            
        case Detail.phoneNumber.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoneNumberCell.id, for: indexPath) as! PhoneNumberCell
            cell.phoneNumber = placeDetailResult?.international_phone_number
            return cell
            
        case Detail.website.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebAddressCell.id, for: indexPath) as! WebAddressCell
            cell.webAddress = placeDetailResult?.website
            return cell
            
        case Detail.actionButtons.rawValue:

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionButtonsCell.id, for: indexPath) as! ActionButtonsCell
            cell.placeId = placeId
            cell.delegate = self
            return cell
            
        case Detail.reviews.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsHolder.id, for: indexPath) as! ReviewsHolder
            cell.horizontalController.reviews = placeDetailResult?.reviews
            cell.horizontalController.didSelectHandler = { [weak self] review in
                let reviewViewController = ReviewDetailViewController()
                reviewViewController.review = review
                self?.navigationController?.show(reviewViewController, sender: self)
            }
            return cell
            
        case Detail.morePlaces.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MorePlacesHolder.id, for: indexPath) as! MorePlacesHolder
            cell.horizontalController.location = location.selectedLocation
            
            cell.horizontalController.placeGroup = PlacesGroup(results: morePlaces)
            cell.horizontalController.didSelectPlaceInCategoriesHandler = { [weak self] placeId in
                guard let location = self?.location else { return }
                let detailController = PlaceDetailsController(placeId: placeId, location: location)
                self?.navigationController?.show(detailController, sender: self)
            }
            return cell
            
        default:
            let errorCell = collectionView.dequeueReusableCell(withReuseIdentifier: errorCellId, for: indexPath)
            return errorCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case Detail.address.rawValue:
            return cellHeight(for: placeDetailResult?.vicinity, desiredHeight: 60)
            
        case Detail.openingHours.rawValue:
            return cellHeight(for: placeDetailResult?.opening_hours, desiredHeight: 60)
            
        case Detail.phoneNumber.rawValue:
            return cellHeight(for: placeDetailResult?.international_phone_number, desiredHeight: 60)
            
        case Detail.website.rawValue:
            return cellHeight(for: placeDetailResult?.website, desiredHeight: 60)
            
        case Detail.actionButtons.rawValue:
            return .init(width: view.frame.width, height: 60)
            
        case Detail.reviews.rawValue:
            return cellHeight(for: placeDetailResult?.reviews, desiredHeight: 180)
            
        case Detail.morePlaces.rawValue:
            return cellHeight(for: morePlaces, desiredHeight: 320)
            
        default:
            return .zero
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case Detail.address.rawValue:
            guard let place = placeDetailResult,
                let longitude = place.geometry?.location.lng,
                let latitude = place.geometry?.location.lat else { return }
            
            openInMaps(place: place, longitude: longitude, latitude: latitude)
            
        case Detail.openingHours.rawValue:
            let openingHoursController = OpeningHoursController()
            openingHoursController.openingHours = placeDetailResult?.opening_hours
            navigationController?.show(openingHoursController, sender: self)
            
        case Detail.website.rawValue:
            let websiteViewController = WebsiteViewController()
            websiteViewController.urlString = placeDetailResult?.website
            navigationController?.show(websiteViewController, sender: self)
            
        case Detail.phoneNumber.rawValue:
            guard let number = placeDetailResult?.international_phone_number else { return }
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
    
    func cellHeight(for detail: Any?, desiredHeight: CGFloat) -> CGSize {
        if detail != nil {
            return .init(width: view.frame.width, height: desiredHeight)
        } else {
            return .zero
        }
    }
    
    func cellHeight(for morePlaces: [PlaceResult]?, desiredHeight: CGFloat) -> CGSize {
        if let morePlaces = morePlaces, morePlaces.count > 0 {
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
            showToastAlert(title: "Number copied to clipboard!")
        }
    }
}

extension PlaceDetailsController: ActionButtonsCellDelegate {
    
    func sharePressed(cell: ActionButtonsCell) {
        let urlString: String?
        
        if let websiteString = placeDetailResult?.website {
            urlString = websiteString
        } else if let googleMapsUrlString = placeDetailResult?.url {
            urlString = googleMapsUrlString
        } else {
            //Unable to retrieve info or something...
            return
        }
        
        guard let urlStr = urlString else { return }
        guard let url = URL(string: urlStr) else { return }
        
        let items: [Any] = [url]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true)
    }
    
}


