//
//  SmallSquarePlaceCell.swift
//  DiscoverPlaces
//
//  Created by user on 13/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SmallPlaceCell: UICollectionViewCell {
    
    public static let id = "smallSquareSpaceCellId"
    
    let placeImageView = UIImageView(image: UIImage(named: ""))
    let placeNameLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .regular), color: .label, numberOfLines: 2) //Can't be more than 2
    let addressLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .regular), color: .secondaryLabel, numberOfLines: 1) //Can't be more that 1
    let starsView = StarsView(width: 80)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        placeImageView.backgroundColor = .secondarySystemBackground
        setupPlaceImageView()
        setupStackView()
    }
    
    func configure(using viewModel: PlaceCellViewModel) {
        placeNameLabel.text = viewModel.placeName
        addressLabel.text = viewModel.address
        guard let rating = viewModel.rating else { return }
        starsView.populate(with: rating)
        guard let url = viewModel.imageURL else { return }
        placeImageView.sd_setImage(with: url)
    }
    
    private func configurePlaceName(using place: PlaceResult) {
        placeNameLabel.text = place.name
    }

    private func buildImageUrl(using photo: Photo) -> URL? {
        guard let url = UrlBuilder.buildImageUrl(with: photo.photoReference, width: photo.width) else {
            return nil
        }
        return url
    }
    
    private func setupPlaceImageView() {
        placeImageView.addGradientBackground(topColor: .clear, bottomColor: .black, start: 0.35, end: 0.45)
        addSubview(placeImageView)
        placeImageView.roundCorners()
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        placeImageView.constrainHeight(constant: 150)
    }
    
    private func setupStackView() {
        let stackView = VerticalStackView(arrangedSubviews: [placeNameLabel, addressLabel, starsView, UIView()], spacing: 4)
        stackView.distribution = .fill
        stackView.alignment = .leading
        addSubview(stackView)
        stackView.anchor(top: placeImageView.bottomAnchor, leading: placeImageView.leadingAnchor, bottom: bottomAnchor, trailing: placeImageView.trailingAnchor, padding: .init(top: 4, left: 4, bottom: 0, right: 4))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

