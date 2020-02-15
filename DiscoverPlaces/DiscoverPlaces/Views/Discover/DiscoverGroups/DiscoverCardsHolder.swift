////
////  DiscoverGroupCell.swift
////  DiscoverPlaces
////
////  Created by user on 28/01/2020.
////  Copyright © 2020 AHApps. All rights reserved.
////
//
//import UIKit
//
//class DiscoverCardsHolder: UICollectionViewCell {
//    
//    let sectionTitle: UILabel! = {
//        let lbl = UILabel()
//        lbl.text = "Section Title"
//        lbl.font = .systemFont(ofSize: 18, weight: .light)
//        return lbl
//    }()
//    
//    let moreButton: UIButton! = {
//        let btn = UIButton(type: .system)
//        btn.constrainHeight(constant: 25)
//        btn.constrainWidth(constant: 25)
//        btn.setImage(UIImage(named: "rightArrow"), for: .normal)
//        btn.contentMode = .scaleAspectFit
//        btn.tintColor = .black
//        btn.addShadow()
//        return btn
//    }()
//    
//    let hackSpacingView: UIView! = {
//        let v = UIView()
//        v.backgroundColor = .clear
//        v.constrainWidth(constant: 16)
//        return v
//    }()
//    
//    let hackSpacingView2: UIView! = {
//        let v = UIView()
//        v.backgroundColor = .clear
//        v.constrainWidth(constant: 16)
//        return v
//    }()
//    
//    let horizontalController = DiscoverGroupHorizontalController()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = .white
//        
//        let topStackView = UIStackView(arrangedSubviews: [hackSpacingView, sectionTitle, moreButton, hackSpacingView2])
//        topStackView.alignment = .fill
//        
//        let stackView = UIStackView(arrangedSubviews: [topStackView, horizontalController.view])
//        stackView.axis = .vertical
//        addSubview(stackView)
//        stackView.fillSuperview()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
