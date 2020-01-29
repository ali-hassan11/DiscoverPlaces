//
//  DiscoverGroupCell.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class DiscoverGroupCell: UICollectionViewCell {
    
    
    
    let sectionTitle: UILabel! = {
        let lbl = UILabel()
        lbl.text = "Section Title"
        lbl.font = .systemFont(ofSize: 18, weight: .light)
        return lbl
    }()
    
    let moreButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .blue
        btn.constrainWidth(constant: 40)
        return btn
    }()
    
    let hackSpacingView: UIView! = {
        let v = UIView()
        v.backgroundColor = .clear
        v.constrainWidth(constant: 12)
        return v
    }()
    
    let hackSpacingView2: UIView! = {
        let v = UIView()
        v.backgroundColor = .clear
        v.constrainWidth(constant: 12)
        return v
    }()
    
    let horizontalController = DiscoverGroupHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let topStackView = UIStackView(arrangedSubviews: [hackSpacingView, sectionTitle, moreButton, hackSpacingView2])
        topStackView.alignment = .fill
        
        let stackView = UIStackView(arrangedSubviews: [topStackView, horizontalController.view])
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
