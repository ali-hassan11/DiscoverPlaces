//
//  AddressCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class AddressCell: UICollectionViewCell {

    public static let id = "addressCellId"
    
    //USE VICINITY, NOT FORMATTED ADDRESS HERE
    var vicinity: String? {
        didSet {
            addressLabel.text = vicinity
        }
    }
    
    let highlightView: UIView! = {
        let v = UIView()
        v.backgroundColor = UIColor.quaternarySystemFill
        return v
    }()
    
    override var isHighlighted: Bool {
        didSet {
            highlightView.isHidden = self.isHighlighted ? false : true
        }
    }
    
    let iconVimageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "mappin.circle.fill"))
        iv.constrainWidth(constant: 30)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let addressLabel = UILabel(text: "123 Buckingham Palace Road, Victoria, London, AB1 2CD", font: .systemFont(ofSize: 16, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)

    let chevronImageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.constrainWidth(constant: 10)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        iconVimageView.contentMode = .scaleAspectFit
        backgroundColor = .systemBackground
        
        configureHighlightView()

        let stackView = HorizontalStackView(arrangedSubviews: [iconVimageView, addressLabel, UIView(), chevronImageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))

        addBottomSeparator()
    }
    
    private func configureHighlightView() {
        addSubview(highlightView)
        highlightView.isHidden = true
        highlightView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

