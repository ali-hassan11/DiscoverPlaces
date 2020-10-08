//TODO: Error controller if error in fetch

import UIKit
import CoreLocation

//protocol HasDetailCoordinator {
//    var coordinator: DetailCoordinatable { get }
//}
//protocol HasHomeCoorinator  {
//    var coordinator: HomeCoordinatable { get }
//}

final class HomeController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {

//    let coord = (HasDetailCoordinator & HasHomeCoorinator).self
    
    private let coordinator: NEWHomeTabCoordinatable
    
    private var userLocation: LocationItem?
    private var locationManager: CLLocationManager!
    
    private var placeResults = [PlaceResult]()
    
    private let activityIndicatorView = LoadingIndicatorView()
    private let fadeView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    init(coordinator: NEWHomeTabCoordinatable) {
        self.coordinator = coordinator
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discover"
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
        
        guard Reachability.isConnectedToNetwork() else {
            self.showRetryConnectionAlert { (_) in
                self.fetchForLastSavedLocation()
            }
            return
        }
        
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
            
            let placeResults = SearchResponseFilter().results(from: response)
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
                    self.pushNoResultsController() //TODO: Coordinator
                }
                
                self.fadeView.removeFromSuperview()
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    //TODO: coordinator.pushErrorCon..
    private func pushNoResultsController() {
        coordinator.pushNoResultsController(message: Constants.noResultsMessage, buttonTitle: Constants.tryDifferentLocationtext, buttonHandler: showSetLocationController)
    }
    
    //TODO: Coordinator
    @objc func showSetLocationController() -> () {
        coordinator.pushSetLocationController(selectedLocationCompletion: updateToSelectedLocation(location:name:),
                                              locateUserCompletion: updateToCurrentUserLocation)
    }
    
    private func updateToSelectedLocation(location: Location, name: String?) -> () {
        let locationStub = LocationItem(name: name, selectedLocation: location, actualUserLocation: userLocation?.actualUserLocation)
        userLocation = locationStub
        updateLastSavedLocation(with: locationStub)
        fetchForLastSavedLocation()
        resetScroll()
    }
    
    private func updateToCurrentUserLocation() -> () {
        determineMyCurrentLocation()
        resetScroll()
    }
    
    private func resetScroll() {
        self.collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true) //Bit glitchy... Need to fix
        
        guard let homeLargeCell = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? HomeLargeCellHolder else { return }
        homeLargeCell.horizontalController.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        
        guard let categoriesHolderCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? CategoriesHolder else { return }
        categoriesHolderCell.horizontalController.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }

    private func didTapPlace(placeId: String) -> Void {
        guard let location = userLocation else { return }
        coordinator.pushDetailController(id: placeId, userLocation: location)
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
            cell.horizontalController.didTapPlaceHandler = didTapPlace
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
                self?.coordinator.pushCategoriesController(category: category, location: location)
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
                print("⚠️ FAILD TO GEOCODE: \(error.localizedDescription)")
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
    
    private func updateLastSavedLocation(with location: LocationItem) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(location)
            UserDefaults.standard.set(data, forKey: Constants.locationKey)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    private func fetchForLastSavedLocation() {
        
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
    
    private func showRetryConnectionAlert(retryHandler: ((UIAlertAction)->())?) {
        let alertController = UIAlertController(title: Constants.noInternetConnectionTitle,
                                                message: Constants.noInternetConnetionMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Retry", style: .default, handler: retryHandler)
        
        alertController.addAction(action)
        alertController.view.tintColor = .systemPink
        
        present(alertController, animated: true, completion: nil)
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
