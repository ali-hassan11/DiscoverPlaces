//
//  HorizontalStackView.swift
//  AppStoreLBTA
//
//  Created by user on 21/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class HorizontalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .horizontal
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}