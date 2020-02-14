//
//  ActionButtonsCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ActionButtonsCell: UICollectionViewCell {

    let favouritesButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.setTitle(" Favourite", for: .normal)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .systemPink
//        btn.constrainWidth(constant: 120)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()

    let bucketListButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.setTitle(" To-Do", for: .normal)
        btn.setImage(UIImage(systemName: "list.dash"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .systemPink
//        btn.constrainWidth(constant: 120)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()

    let shareButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.setTitle(" Share", for: .normal)
        btn.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .systemPink
//        btn.constrainWidth(constant: 120)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground

        let stackView = HorizontalStackView(arrangedSubviews: [favouritesButton, bucketListButton, shareButton], spacing: 8)
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 20, bottom: 10, right: 20))

        addBottomSeparator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
