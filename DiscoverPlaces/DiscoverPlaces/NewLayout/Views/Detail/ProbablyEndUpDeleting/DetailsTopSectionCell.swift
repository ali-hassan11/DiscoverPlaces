////
////  TopSectionDetailsCell.swift
////  DiscoverPlaces
////
////  Created by user on 09/02/2020.
////  Copyright © 2020 AHApps. All rights reserved.
////
//
//import UIKit
//
//class DetailsTopSectionCell: UICollectionViewCell {
//    
////    var place: PlaceDetailResult? {
////        didSet {
////            placeNameLabel.text = place?.name
////            addressLabel.text = place?.vicinity
////        }
////    }
//    
//    //Sync label font with cell
//    let placeNameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 24), color: .label, alignment: .center, numberOfLines: 0)
//    
//    let addressLabel = UILabel(text: "123 Buckingham Place Place, Victoria, London, United Kingdom, E17 7AJ", font: .systemFont(ofSize: 19), color: .secondaryLabel, alignment: .center, numberOfLines: 0)
//    
//    let starView: UIView! = {
//        let v = UIView()
//        v.backgroundColor = UIColor.systemPink
//        v.constrainHeight(constant: 22)
//        v.constrainWidth(constant: 115)
//        return v
//    }()
//    
//    let reviewsButton: UIButton! = {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "reviewsButton"), for: .normal)
//        btn.imageView?.contentMode = .scaleAspectFit
//        btn.constrainWidth(constant: 80)
//        return btn
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = .lightGray
//        
//        let ratingsStackView = UIStackView(arrangedSubviews: [UIView(), starView, reviewsButton, UIView()])
//        ratingsStackView.spacing = 6
//        
//        let topStackView = VerticalStackView(arrangedSubviews: [placeNameLabel,
//                                                                       addressLabel,
//                                                                       ratingsStackView], spacing: 8)
//        topStackView.alignment = .center
//        
//        addSubview(topStackView)
//        topStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
