import UIKit
import Foundation

protocol TypographyProvider {
    
    var regularCellTitle: [NSAttributedString.Key: Any] { get }

}

public final class DefaultTypography: TypographyProvider {
    
    var regularCellTitle: [NSAttributedString.Key: Any] {
        return [
            .font : UIFont.systemFont(ofSize: 10),
            .foregroundColor : UIColor.red
        ]
    }
    
}
