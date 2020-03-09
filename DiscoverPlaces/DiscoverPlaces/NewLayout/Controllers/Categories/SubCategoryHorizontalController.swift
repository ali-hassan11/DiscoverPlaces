//
//  SubCategoryHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 09/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SubCategoryHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
        
    var didSelectPlaceInCategoriesHandler: ((String, String) -> ())?
    
    var places: [PlaceResult]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SmallSquareSpaceCell.self, forCellWithReuseIdentifier: SmallSquareSpaceCell.id)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallSquareSpaceCell.id, for: indexPath) as! SmallSquareSpaceCell
        let place = places?[indexPath.item]
        cell.place = place
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let placeId = places?[indexPath.item].place_id, let name = places?[indexPath.item].name else { return }
        didSelectPlaceInCategoriesHandler?(placeId, name)
    }
    
}

//Use this for morePlaces
class SmallSquareSpaceCell: UICollectionViewCell {
    
    public static let id = "smallSquareSpaceCellId"
    
    let placeImageView = UIImageView(image: UIImage(named: "food"))
    let placeNameLabel = UILabel(text: "Burj Khalifah Hotel - Dubai", font: .systemFont(ofSize: 16, weight: .medium), color: .white, numberOfLines: 1)
    let starsView = StarsView(width: 80)

    var place: PlaceResult? {
        didSet {
            print(place?.name!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeImageView.addGradientBackground(topColor: .clear, bottomColor: .black, start: 0.325, end: 0.425)
        
        addSubview(placeImageView)
        placeImageView.roundCorners()
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 40, right: 0))
        
        addSubview(placeNameLabel)
        placeNameLabel.anchor(top: placeImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        starsView.backgroundColor = .systemPink
        addSubview(starsView)
        starsView.populate(with: 4.5)
        starsView.anchor(top: placeNameLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
