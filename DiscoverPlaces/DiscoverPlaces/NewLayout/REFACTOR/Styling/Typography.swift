import UIKit
import Foundation

protocol DefaultTypographyProvider {
    var distanceLabel: [NSAttributedString.Key: Any] { get }
    var regularCellTitle: [NSAttributedString.Key: Any] { get }
    var sectionHeading: [NSAttributedString.Key: Any] { get }
}

class DefaultTypography: DefaultTypographyProvider {
    
    var distanceLabel: [NSAttributedString.Key: Any] {
        return [.font : UIFont.systemFont(ofSize: 15.5, weight: .medium),
                .foregroundColor : UIColor(white: 1, alpha: 0.75)]
    }
    
    var regularCellTitle: [NSAttributedString.Key : Any] {
        return [.font : UIFont.systemFont(ofSize: 16, weight: .semibold),
        .foregroundColor : UIColor.label]
    }
    
    var sectionHeading: [NSAttributedString.Key : Any] {
        return [.font : UIFont.systemFont(ofSize: 19, weight: .medium),
                .foregroundColor : UIColor.label]
    }
}

//
protocol PlaceDetailTypographyProvider {
    var placeNameLargeTitle: [NSAttributedString.Key: Any] { get }
}

extension DefaultTypography: PlaceDetailTypographyProvider {
    
    var placeNameLargeTitle: [NSAttributedString.Key: Any] {
        return [.font : UIFont.systemFont(ofSize: 24, weight: .semibold),
                .foregroundColor : UIColor.white]
    }

}
