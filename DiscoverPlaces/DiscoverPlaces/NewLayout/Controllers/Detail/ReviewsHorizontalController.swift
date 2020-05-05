//
//  File.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class ReviewsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var reviews: [Review]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectHandler: ((Review) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.id)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.id, for: indexPath) as! ReviewCell
        cell.review = reviews?[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if let review = reviews?[indexPath.item] {
             didSelectHandler?(review)
         }
     }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if reviews != nil {
            return .init(width: (view.frame.width - (Constants.leftPadding + Constants.rightPadding + 10)), height: view.frame.height)
        } else {
            return.zero
        }
    }
}

