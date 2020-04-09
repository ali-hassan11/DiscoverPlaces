//
//  Fonts.swift
//  DiscoverPlaces
//
//  Created by user on 09/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class Font {
    let distanceLabel = UILabel(text: "", font: .systemFont(ofSize: 15.5, weight: .medium), color: Color.distanceLabel, numberOfLines: 1)
}

enum Color {
    static let distanceLabel = UIColor(white: 1, alpha: 0.75)
    static let starRatingNumber = UIColor(white: 1, alpha: 0.75)
}
