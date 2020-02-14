//
//  HomeLargeCellsHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class HomeLargeCellsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let largeCellId = "largeCellId"
    
    //Add didselect ting here & call in didSelectItemAt with (result[indexPath.row])
    //Add closure to HomeController cellForItem
    var didSelectHandler: ((PlaceResult) -> ())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let result = results?[indexPath.item] {
            didSelectHandler?(result)
        }
    }
        
    var results: [PlaceResult]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HomeLargeCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView.contentInset = .init(top: Constants.topPadding, left: Constants.leftPadding, bottom: Constants.bottomPadding, right: Constants.rightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let result = results?[indexPath.item] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! HomeLargeCell
        cell.result = result
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - (Constants.leftPadding + Constants.rightPadding), height: view.frame.height - (Constants.topPadding + Constants.bottomPadding + 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
