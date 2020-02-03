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
    
    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
    }
    
}

extension UILabel {
    convenience init(text: String, font: UIFont? = nil, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(conrnerRadius: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil, borderColor: CGColor? = nil, borderWidth: CGFloat? = nil) {
        self.init(image: nil)
        
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        
        if let conrnerRadius = conrnerRadius {
            self.layer.cornerRadius = conrnerRadius
        }

        if let width = width {
            self.constrainWidth(constant: width)
        }
        
        if let height = height {
            self.constrainHeight(constant: height)
        }
        
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor
        }
        
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
    }
}

extension UIButton {
    convenience init (title: String, textColor: UIColor, width: CGFloat? = nil, height: CGFloat? = nil, font: UIFont?, backgroundColor: UIColor?, cornerRadius: CGFloat? = nil) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        
        if let width = width {
            self.constrainWidth(constant: width)
        }
        
        if let height = height {
            self.constrainHeight(constant: height)
        }
        
        if let cornerRadius = cornerRadius{
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
}