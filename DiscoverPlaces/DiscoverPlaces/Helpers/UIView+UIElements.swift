//
//  File.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

extension UIView {
    
    func addOverlay(color: UIColor, alpha: CGFloat) {
        let overlay = UIView(frame: frame)
        overlay.backgroundColor = color.withAlphaComponent(alpha)
        addSubview(overlay)
        overlay.fillSuperview()
    }
    
}
