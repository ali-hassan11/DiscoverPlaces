//
//  ErrorCell.swift
//  DiscoverPlaces
//
//  Created by user on 03/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class ErrorCell: UICollectionViewCell {
    
    static let id = "id"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        #if DEBUG
        let errorLabel = UILabel(text: "Error", color: .label, alignment: .center, numberOfLines: 1)
        errorLabel.backgroundColor = .systemRed
        addSubview(errorLabel)
        errorLabel.fillSuperview()
        #endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
