//
//  ImageCell.swift
//  DiscoverPlaces
//
//  Created by user on 09/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
        
    let imageView = UIImageView()
    
    var photo: Photo? {
        didSet {
            guard let photo = photo else { return }
            guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else { return }
            imageView.sd_setImage(with: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        imageView.addGradientBackground(firstColor: .black, secondColor: .clear)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
