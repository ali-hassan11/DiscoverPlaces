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
    
    var place: PlaceDetailResult?
    
    var placeId: String? {
        didSet {
            //SHOW PLACEHOLDERS VIEW UNIL ALL DATA IS LOADED, WHEN LOADED PASS INTO CELL'S DID SET PROPERTY 💯
            if let id = placeId {
                fetchData(for: id)
            }
        }
    }
    
    func fetchData(for id: String) {
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(id)&fields=name,opening_hours,photo,vicinity,geometry,review,website,url&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Falied to fetch: ", error)
                return
            }
            //success
            guard let data = data else { return }
            
            do {
                let placeResponse = try JSONDecoder().decode(PlaceDetailResponse.self, from: data)
//                print(placeResponse.result ?? "WHOOPS: No Results")
                self.place = placeResponse.result
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let jsonErr {
                print(jsonErr)
                return
            }
        }.resume()
    }

    // MARK: - Result

    //MOVE CELL ID'S TO CELLS AS STATIC LETS
    fileprivate let placeImagesHolderId = "placeImagesHolderId"
    fileprivate let addressCellId = "addressCellId"
    fileprivate let openingTimeCellId = "openingTimeCellId"
    fileprivate let phoneNumberCellId = "phoneNumberCellId"
    fileprivate let webAddressCellId = "webAddressCellId"

    fileprivate let actionButtonsCellId = "actionButtonsCellId"

    fileprivate let reviewsHolderId = "reviewsHolderId"
    fileprivate let morePlacesHolderId = "morePlacesHolderId"

    fileprivate let errorCellId = "errorCellId"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .never
        navigationItem.largeTitleDisplayMode = .never

        //Header
        collectionView.register(PlaceImagesHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: placeImagesHolderId)

        //DetailCells
        collectionView.register(AddressCell.self, forCellWithReuseIdentifier: addressCellId)
        collectionView.register(OpeningTimeCell.self, forCellWithReuseIdentifier: openingTimeCellId)
        collectionView.register(PhoneNumberCell.self, forCellWithReuseIdentifier: phoneNumberCellId)
        collectionView.register(WebAddressCell.self, forCellWithReuseIdentifier: webAddressCellId)

        //ButtonsCell
        collectionView.register(ActionButtonsCell.self, forCellWithReuseIdentifier: actionButtonsCellId)

        //ReviewsHolder
        collectionView.register(ReviewsHolder.self, forCellWithReuseIdentifier: reviewsHolderId)

        //MorePlacesHolder
        collectionView.register(MorePlacesHolder.self, forCellWithReuseIdentifier: morePlacesHolderId)

        //Error
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: errorCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    //Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: placeImagesHolderId, for: indexPath) as! PlaceImagesHolder
        
        cell.pageControlView.numberOfPages = place?.photos?.count ?? 0
        cell.horizontalController.photos = place?.photos
        cell.horizontalController.didEndAccelerating = { index in //weak self?
            cell.pageControlView.currentPage = index
        }
        return cell
    }
    
    //Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height:  (view.layoutMarginsGuide.layoutFrame.height / 2) + 64)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            //Address
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addressCellId, for: indexPath) as! AddressCell
            cell.vicinity = place?.vicinity
            return cell
        case 1:
            //Hours
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: openingTimeCellId, for: indexPath) as! OpeningTimeCell
            cell.openingTimes = place?.opening_hours?.weekdayText ?? []//GET THE CORRECT DOTW
            return cell
        case 2:
            //PhoneNumber
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: phoneNumberCellId, for: indexPath) as! PhoneNumberCell
            cell.phoneNumber = place?.formatted_Phone_Number
            return cell
        case 3:
            //Website
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: webAddressCellId, for: indexPath) as! WebAddressCell
            cell.webAddress = place?.website
            return cell
        case 4:
            //ActionButtons
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: actionButtonsCellId, for: indexPath) as! ActionButtonsCell
            cell.placeId = placeId
            cell.delegate = self
            return cell
        case 5:
            //Reviews
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsHolderId, for: indexPath) as! ReviewsHolder
            cell.horizontalController.reviews = place?.reviews
            cell.horizontalController.didSelectHandler = { [weak self] review in
                let reviewViewController = ReviewDetailViewController()
                reviewViewController.review = review
                self?.navigationController?.show(reviewViewController, sender: self)
            }
            return cell
        case 6:
            //More Places
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: morePlacesHolderId, for: indexPath) as! MorePlacesHolder
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
            //REFACTOR THESE IS STATEMENTS
        case 0:
            //Address
            if place?.vicinity != nil {
                return .init(width: view.frame.width, height: 60)
            } else {
                return .zero
            }
        case 1:
            //Hours
            if place?.opening_hours != nil {
                return .init(width: view.frame.width, height: 60)
            } else {
                return .zero
            }
        case 2:
            //PhoneNumber
            if place?.formatted_Phone_Number != nil {
                return .init(width: view.frame.width, height: 60)
            } else {
                return .zero
            }
        case 3:
            //Website
            if place?.website != nil {
                return .init(width: view.frame.width, height: 60)
            } else {
                return .zero
            }
        case 4:
            //ActionButtons
            return .init(width: view.frame.width, height: 60)
        case 5:
            //Reviews
            if place?.reviews != nil {
                return .init(width: view.frame.width, height: 180)
            } else {
                return .zero
            }
        case 6:
            //More Places
            //CHECK IF NIL, IF NOT RETURN 180
            return .init(width: view.frame.width, height: 220)
        default:
            return .zero
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case Detail.address.rawValue:
            
            guard let place = place,
            let name = place.name,
            let longitude = place.geometry?.location?.lng,
            let latitude = place.geometry?.location?.lat else { return }
            
            openInMaps(placeName: name, longitude: longitude, latitude: latitude)
            
        case Detail.openingHours.rawValue:
            let openingHoursController = OpeningHoursController()
            openingHoursController.openingHours = place?.opening_hours
            navigationController?.show(openingHoursController, sender: self)
            
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
    
    private func openInMaps(placeName: String, longitude: Double, latitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(longitude, latitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = placeName
        mapItem.phoneNumber = place?.formatted_Phone_Number
        mapItem.url = URL(string: place?.website ?? "")
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
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
        
        let items = [url]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
}
