//
//  MultipleCategoriesController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MultipleCategoriesController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
        
    private let searchResponseFilter = SearchResponseFilter()
    private let dispatchGroup = DispatchGroup()
    
    private var location: LocationItem
    private var category: Category
    
    private var subCategoryGroups = [PlacesGroup]()
        
    init(category: Category, location: LocationItem) {
        self.location = location
        self.category = category
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupCollectionView()
        
        fetchSubCategoryGroups(category: category, selectedLocation: location.selectedLocation)
    }

    private func setupCollectionView() {
        collectionView.alpha = 0
        collectionView.reloadData()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubCategoryiesHolder.self, forCellWithReuseIdentifier: SubCategoryiesHolder.id)
        collectionView.register(GoogleLogoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: GoogleLogoCell.id)
    }
    
    private func fetchSubCategoryGroups(category: Category, selectedLocation: Location?) {
        category.subCategories().forEach {
            dispatchGroup.enter()
            fetchdata(subCategory: $0, selectedLocation: location.selectedLocation)
        }
    }
        
    private func fetchdata(subCategory: SubCategory, selectedLocation: Location) {
        
        print("FetchData for \(subCategory)")
        var subCategoryGroup: PlacesGroup?
        Service.shared.fetchNearbyPlaces(selectedLocation: selectedLocation, subCategory: subCategory) { (response, error) in
            
            if let error = error {
                print("Failed to fetch: \(error)")
                return
            }
            
            //success
            guard let response = response else { return }
            
            let placeResults = self.searchResponseFilter.results(from: response)
            subCategoryGroup = PlacesGroup(title: subCategory.formatted(), results: placeResults)
            self.dispatchGroup.leave()
            
            self.handleSuccess(with: subCategoryGroup)
        }
    }
    
    private func handleSuccess(with subCategoryGroup: PlacesGroup?) {
        dispatchGroup.notify(queue: .main) {
            guard let subCategoryGroup = subCategoryGroup, subCategoryGroup.results.count > 0 else { return }
            self.subCategoryGroups.append(subCategoryGroup)
            self.subCategoryGroups.sort{$0.results.count > $1.results.count}
            self.collectionView.reloadData()
            UIView.animate(withDuration: 0.35) {
                self.collectionView.alpha = 1
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MultipleCategoriesController {
    
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return subCategoryGroups.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryiesHolder.id, for: indexPath) as! SubCategoryiesHolder
            
            let subCategoryGroup = subCategoryGroups[indexPath.item]
            cell.subCategoryTitleLabel.text = subCategoryGroup.title
            cell.horizontalController.placeGroup = subCategoryGroup
            cell.horizontalController.location = self.location.selectedLocation
            cell.horizontalController.didSelectPlaceInCategoriesHandler = { [weak self] placeId in
                guard let location = self?.location else { return }
                let detailsController = PlaceDetailsController(placeId: placeId, location: location)
                self?.navigationController?.pushViewController(detailsController, animated: true)
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return .init(width: view.frame.width, height: 280)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }
    
    // MARK: GoogleCell Footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GoogleLogoCell.id, for: indexPath) as! GoogleLogoCell
        cell.addTopSeparator()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: Constants.googleFooterHeight)
    }
}
