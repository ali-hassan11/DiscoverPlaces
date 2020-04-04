//
//  PhoneCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class PhoneNumberCell: UICollectionViewCell {
    
    public static let id = "phoneNumberCellId"
    
    var phoneNumber: String? {
        didSet {
            phoneNumberLabel.text = phoneNumber
        }
    }
    
    let iconVimageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "phone.circle.fill"))
        iv.constrainWidth(constant: 30)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let phoneNumberLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)

    let chevronImageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.constrainWidth(constant: 10)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground

        configureHighlightView()
        
        let stackView = HorizontalStackView(arrangedSubviews: [iconVimageView, phoneNumberLabel, UIView(), chevronImageView], spacing: 12)
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
