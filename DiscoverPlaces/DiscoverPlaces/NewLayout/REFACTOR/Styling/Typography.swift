import UIKit
import Foundation

protocol TypographyProvider {
    var regularCellTitle: [NSAttributedString.Key: Any] { get }
    var distanceLabel: [NSAttributedString.Key: Any] { get }
}

class DefaultTypography: TypographyProvider {
    
    var regularCellTitle: [NSAttributedString.Key : Any] {
        return [.font : UIFont.systemFont(ofSize: 16, weight: .semibold),
        .foregroundColor : UIColor.label]
    }
    
    var distanceLabel: [NSAttributedString.Key: Any] {
        return [.font : UIFont.systemFont(ofSize: 15.5, weight: .medium),
                .foregroundColor : UIColor(white: 1, alpha: 0.75)]
    }
}

//
protocol PlaceDetailTypography {
    var placeNameLargeTitle: [NSAttributedString.Key: Any] { get }
}

extension DefaultTypography: PlaceDetailTypography {
    
    var placeNameLargeTitle: [NSAttributedString.Key: Any] {
        return [.font : UIFont.systemFont(ofSize: 24, weight: .semibold),
                .foregroundColor : UIColor.white]
    }
}
