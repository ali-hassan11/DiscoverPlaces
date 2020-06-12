import UIKit
import Foundation

protocol TypographyProvider {
    
    var regularCellTitle: [NSAttributedString.Key: Any] { get }

}

public final class PlaceDetailTypography: TypographyProvider {
    
    var regularCellTitle: [NSAttributedString.Key: Any] {
        return [
            .font : UIFont.systemFont(ofSize: 16),
            .foregroundColor : UIColor.label
        ]
    }
    
}
