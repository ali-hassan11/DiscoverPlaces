//
//  DetailsViewController.swift
//  DiscoverPlaces
//
//  Created by user on 06/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceDetailsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {

    var place: PlaceDetailResult?
    var numberOfImages = 0 //Temp

    var placeId: String? {
        didSet {
            //SHOW PLACEHOLDERS UNTIL ALL DATA IS LOADED, WHEN LOADED PASS INTO CELL'S DID SET PROPERTY 💯
            //MOVE FETCH TO SERVICE
            if let id = placeId {
                fetchData(for: id)
            }
            
            numberOfImages = 5 //Temp
        }
    }
    
    func fetchData(for id: String) {
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(id)&fields=name,vicinity,formatted_phone_number&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Falied to fetch: ", error)
                return
            }
            //success
            guard let data = data else { return }
            print(data)
            
            do {
                let placeResponse = try JSONDecoder().decode(PlaceDetailResponse.self, from: data)
                print(placeResponse.result ?? "WHOOPS")
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
    
    //Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: placeImagesHolderId, for: indexPath) as! PlaceImagesHolder
        cell.pageControlView.numberOfPages = numberOfImages
        cell.horizontalController.didEndAccelerating = { index in //weak self?
            cell.pageControlView.currentPage = index
        }
        return cell
    }
    
    //Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 280)
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
            return cell
        case 2:
            //PhoneNumber
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: phoneNumberCellId, for: indexPath) as! PhoneNumberCell
            return cell
        case 3:
            //Website
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: webAddressCellId, for: indexPath) as! WebAddressCell
            return cell
        case 4:
            //Reviews
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: actionButtonsCellId, for: indexPath) as! ActionButtonsCell
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsHolderId, for: indexPath) as! ReviewsHolder
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
        case 0:
            //Address
            return .init(width: view.frame.width, height: 60)
        case 1:
            //Hours
            return .init(width: view.frame.width, height: 60)
        case 2:
            //PhoneNumber
            return .init(width: view.frame.width, height: 60)
        case 3:
            //Website
            return .init(width: view.frame.width, height: 60)
        case 4:
            //ActionButtons
            return .init(width: view.frame.width, height: 60)
        case 5:
            //Reviews
            return .init(width: view.frame.width, height: 180)
        case 6:
            //More Places
            return .init(width: view.frame.width, height: 220)
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
}
