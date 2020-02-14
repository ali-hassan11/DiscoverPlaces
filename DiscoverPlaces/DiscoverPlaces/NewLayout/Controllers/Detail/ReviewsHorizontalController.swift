//
//  File.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ReviewsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {

    fileprivate let reviewCellId = "reviewCellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .systemBackground
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width - (Constants.leftPadding + Constants.rightPadding + 10)), height: view.frame.height)
    }
}

