//
//  WebsiteCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class WebAddressCell: UICollectionViewCell {
    
    public static let id = "webAddressCellId"
    
//    var webAddress: String? {
//        didSet {
//            websiteAddressLabel.text = webAddress
//        }
//    }
    
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
        let iv = UIImageView(image: UIImage(systemName: "globe"))
        iv.constrainWidth(constant: 30)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let websiteAddressLabel = UILabel(text: "View website", font: .systemFont(ofSize: 16, weight: .semibold), color: .label, alignment: .left, numberOfLines: 1)
    
    let arrowIconImageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.constrainWidth(constant: 10)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(highlightView)
        highlightView.isHidden = true
        highlightView.fillSuperview()
        
        backgroundColor = .systemBackground
        
        let stackView = HorizontalStackView(arrangedSubviews: [iconVimageView, websiteAddressLabel, UIView(), arrowIconImageView], spacing: 12)
        addSubview(stackView)
        stackView.alignment = .center
        stackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        addBottomSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
