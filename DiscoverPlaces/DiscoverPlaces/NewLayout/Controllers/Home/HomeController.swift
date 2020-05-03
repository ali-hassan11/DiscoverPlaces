//
//  HomeController.swift
//  DiscoverPlaces
//
//  Created by user on 05/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//
import UIKit
import CoreLocation

class HomeController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var userLocation: LocationItem?
    private var locationManager:CLLocationManager!
    
    private var placeResults = [PlaceResult]()
    private let searchResponseFilter = SearchResponseFilter()
    
    private let activityIndicatorView = LoadingIndicatorView()
    private let fadeView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingView()
        navigationItem.largeTitleDisplayMode = .always
        setupBarButtons()
        setupCollectionView()
        
        fetchDataAfterDelay()
    }
    
    private func fetchDataAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if UserDefaults.isFirstLaunch() {
                self.determineMyCurrentLocation()
            } else {
                self.fetchForLastSavedLocation()
            }
        }
    }
    
    private func setupBarButtons() {
        let locationBarButton = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(showSetLocationController))
        locationBarButton.tintColor = .systemPink
        navigationItem.rightBarButtonItem = locationBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupCollectionView() {
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoriesHolder.self, forCellWithReuseIdentifier: CategoriesHolder.id)
        collectionView.register(HomeLargeCellHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeLargeCellHolder.id)
        collectionView.register(GoogleLogoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: GoogleLogoCell.id)
    }
    
    private func setupLoadingView() {
        view.addSubview(fadeView)
        fadeView.alpha = 1
        fadeView.fillSuperview()
        
        fadeView.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userLocation = UserLoation.lastSavedLocation()
        collectionView.reloadData()
    }
    
    private func fetchPlacesData(location: LocationItem) {
                
        Service.shared.fetchNearbyPlaces(location: location.selectedLocation) { (response, error) in
            
            if let error = error {
                print("Failed to fetch places: ", error)
                return
            }
            
            //success
            guard let response = response else {
                print("No results?")
                return
            }
            
            let placeResults = self.searchResponseFilter.results(from: response)
            self.handleFetchSuccess(with: placeResults)
        }
    }
    
    private func handleFetchSuccess(with placeResults: [PlaceResult]) {
        
        DispatchQueue.main.async {
            self.placeResults = placeResults
            
            UIView.animate(withDuration: 0.5, animations: {
                self.fadeView.alpha = 0
            }) { _ in
                if placeResults.isEmpty {
                    self.presentErrorController()
                }
                
                self.fadeView.removeFromSuperview()
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func presentErrorController() {
        let errorController = ErrorController(title: Constants.noResultsTitle,
                                              message: Constants.noResultsMessage,
                                              buttonTitle: Constants.tryDifferentLocationtext) {
                                                ///DidTapActionButtonHandler
                                                self.showSetLocationController()
        }
        self.navigationController?.pushViewController(errorController, animated: true)
    }

    @objc func showSetLocationController() {
        let locationSearchController = LocationSearchController()
        
        locationSearchController.selectedLocationCompletionHandler = { [weak self] location, name in
            guard let location = location else { return }
            let locationStub = LocationItem(name: name, selectedLocation: location, actualUserLocation: self?.userLocation?.actualUserLocation)
            self?.userLocation = locationStub
            self?.updateLastSavedLocation(with: locationStub)
            self?.fetchForLastSavedLocation()
            self?.resetScroll()
        }
        
        locationSearchController.determineUserLocationCompletionHandler = { [weak self] in
            self?.determineMyCurrentLocation()
            self?.resetScroll()
        }
        
        navigationController?.pushViewController(locationSearchController, animated: true)
    }
    
    private func resetScroll() {
        self.collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true) //Bit glitchy... Need to fix
        
        guard let homeLargeCell = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? HomeLargeCellHolder else { return }
        homeLargeCell.horizontalController.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        
        guard let categoriesHolderCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? CategoriesHolder else { return }
        categoriesHolderCell.horizontalController.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
}

extension HomeController {
    //MARK: Home Large Cell Header & GoogleCell Footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeLargeCellHolder.id, for: indexPath) as! HomeLargeCellHolder
            cell.horizontalController.userLocation = self.userLocation
            cell.horizontalController.results = placeResults
            cell.configureTitle(with: userLocation?.name)
            cell.horizontalController.didSelectHandler = { [weak self] result in //Only need placeId
                guard let placeId = result.place_id, let location = self?.userLocation else { return }
                let detailsController = PlaceDetailsController(placeId: placeId, location: location)
                self?.navigationController?.pushViewController(detailsController, animated: true)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GoogleLogoCell.id, for: indexPath) as! GoogleLogoCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width + 10 - 32)
    }
    
    //MARK: Categories Controller
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesHolder.id, for: indexPath) as! CategoriesHolder
            cell.horizontalController.didSelectCategory = { [weak self] category in
                guard let location = self?.userLocation else { return }
                let multipleCategoriesController = MultipleCategoriesController(category: category, location: location)
                multipleCategoriesController.title = category.rawValue
                self?.navigationController?.pushViewController(multipleCategoriesController, animated: true)
            }
            return cell
        default:
            return ErrorCell() // TODO: - Register
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return .init(width: view.frame.width, height: 380)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: GoogleCell Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: Constants.googleFooterHeight)
    }
}

extension HomeController: CLLocationManagerDelegate {
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .restricted, .denied:
            fetchForLastSavedLocation()
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            
        default:
            fetchForLastSavedLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        let location = locations[0] as CLLocation
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            
            #if DEBUG
            if let error = error {
                self.showToastAlert(title: "Error Geocoding", message: error.localizedDescription)
                print(error.localizedDescription)
            }
            #endif
            
            let placeName = placeMarks?.first?.locality
            
            let locationCoords = Location(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            let locationStub = LocationItem(name: placeName, selectedLocation: locationCoords, actualUserLocation: locationCoords)
            
            self.userLocation = locationStub
            self.updateLastSavedLocation(with: locationStub)
            self.fetchForLastSavedLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error, when trying to get location: \(error)")
        fetchForLastSavedLocation()
    }
    
    func updateLastSavedLocation(with location: LocationItem) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(location)
            UserDefaults.standard.set(data, forKey: Constants.locationKey)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func fetchForLastSavedLocation() {
        guard Reachability.isConnectedToNetwork() else {
            self.showRetryConnectionAlert { (_) in
                self.fetchForLastSavedLocation()
            }
            return
        }
        
        if let data = UserDefaults.standard.data(forKey: Constants.locationKey) {
            do {
                let lastSavedLocation = try JSONDecoder().decode(LocationItem.self, from: data)
                self.userLocation = lastSavedLocation
                self.fetchPlacesData(location: lastSavedLocation)
            } catch {
                print("Unable to Decode Note (\(error))")
                self.fetchPlacesData(location: LocationItem(name: "Dubai", selectedLocation: Location(lat: 25.1412, lng: 55.1852), actualUserLocation: nil)) //Decide on a Default location (Currently Dubai)
            }
        } else {
            self.fetchPlacesData(location: LocationItem(name: "Dubai", selectedLocation: Location(lat: 25.1412, lng: 55.1852), actualUserLocation: nil)) //Decide on a Default location (Currently Dubai)
        }
    }
    
}

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
