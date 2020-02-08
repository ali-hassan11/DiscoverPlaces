//
//  DetailsViewController.swift
//  DiscoverPlaces
//
//  Created by user on 06/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PlaceDetailsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let placeImagesHolderId = "placeImagesHolderId"
    
    var place: Result?
    
    var placeId: String! {
        didSet {
            print(place?.photos)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        //Header 1
        collectionView.register(PlaceImagesHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: placeImagesHolderId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
    }
    
    //Header 2
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: placeImagesHolderId, for: indexPath)
        return cell
    }
    
    //Header 3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 280)
    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = 
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
    
}

class PlaceImagesHolder: UICollectionReusableView {
    
    let horizontalController = ImagesHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ImagesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .blue
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "imageCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class ImageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


