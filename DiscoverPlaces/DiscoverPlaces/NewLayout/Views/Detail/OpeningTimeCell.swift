//
//  PlaceAddressCell.swift
//  DiscoverPlaces
//
//  Created by user on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class OpeningTimeCell: UICollectionViewCell {
    
    var openingTimes: [String]? {
        didSet {
            let today = Date().dayOfWeek()
            openingTimes?.forEach({ (openingTime) in
                if openingTime.hasPrefix(today ?? "") {
                    openingHoursLabel.text = openingTime
                    return
                }
            }) 
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(highlightView)
        highlightView.isHidden = true
        highlightView.fillSuperview()
        
        backgroundColor = .systemBackground
        layoutCellViews()
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
        let iv = UIImageView(image: UIImage(systemName: "clock.fill"))
        iv.constrainWidth(constant: 30)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let openingHoursLabel = UILabel(text: "Today: 09:00 - 15:00", font: .systemFont(ofSize: 16, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)
    
    let arrowIconImageView: UIImageView! = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.constrainWidth(constant: 10)
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutCellViews() {
        let stackView = HorizontalStackView(arrangedSubviews: [iconVimageView, openingHoursLabel, UIView(), arrowIconImageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        addBottomSeparator()
    }
    
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}

