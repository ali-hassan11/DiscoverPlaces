//
//  File.swift
//  DiscoverPlaces
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    func addBottomSeparator() {
        let separator = UIView()
        separator.backgroundColor = .quaternaryLabel
        separator.constrainHeight(constant: 1)
        addSubview(separator)
        separator.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 12))

    }
}

public class PaddingView: UIView {
    convenience init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.init()
        backgroundColor = .clear
        
        if let width = width {
            constrainWidth(constant: width)
        }
        
        if let height = height {
            constrainHeight(constant: height)
        }
    }
}

extension UIView {
    
    func addOverlay(color: UIColor, alpha: CGFloat) {
        let overlay = UIView(frame: frame)
        overlay.backgroundColor = color.withAlphaComponent(alpha)
        addSubview(overlay)
        overlay.fillSuperview()
    }
    
    func roundCorners() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.masksToBounds = false
    }
    
    func addGradientBackground(topColor: UIColor, bottomColor: UIColor, start: CGFloat, end: CGFloat){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = self.frame
        gradientLayer.startPoint = CGPoint(x: 0, y: start)
        gradientLayer.endPoint = CGPoint(x: 0, y: end)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

extension UILabel {
    convenience init(text: String, font: UIFont? = nil, color: UIColor? = nil, alignment: NSTextAlignment? = nil, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
        if let alignment = alignment {
            self.textAlignment = alignment
        }
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

extension UIViewController {
    func showToastAlert(title: String, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.view.tintColor = .systemPink

        present(alertVC, animated: true) {
            _ = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { timer in
                alertVC.dismiss(animated: true, completion: nil)
            }
        }
    }
}
