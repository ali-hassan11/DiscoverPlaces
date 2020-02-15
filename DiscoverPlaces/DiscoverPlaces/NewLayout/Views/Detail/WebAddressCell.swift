//
//  WebsiteCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class WebAddressCell: UICollectionViewCell {

    var webAddress: String? {
        didSet {
            websiteAddressLabel.text = webAddress
        }
    }
    
    let iconVimageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "globe"))
        iv.constrainWidth(constant: 30)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let websiteAddressLabel = UILabel(text: "www.mywebsite.com", font: .systemFont(ofSize: 16, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)

    let arrowIconImageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.constrainWidth(constant: 10)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground

        let stackView = HorizontalStackView(arrangedSubviews: [iconVimageView, websiteAddressLabel, UIView(), arrowIconImageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))

        addBottomSeparator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
