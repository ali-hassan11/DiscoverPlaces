//
//  ActivityIndicatorView.swift
//  DiscoverPlaces
//
//  Created by user on 23/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {
    
    private let loadingIndicatorView: UIActivityIndicatorView = {
        let liv = UIActivityIndicatorView(style: .medium)
        liv.color = .secondaryLabel
        liv.startAnimating()
        liv.hidesWhenStopped = true
        return liv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addToView()
    }
    
    public func startAnimating() {
        loadingIndicatorView.startAnimating()
    }
    
    public func stopAnimating() {
        loadingIndicatorView.stopAnimating()
    }
 
    private func addToView() {
        addSubview(loadingIndicatorView)
        loadingIndicatorView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
