import UIKit
import Foundation

struct RegularDetailViewModel: DetailItemViewModel {
    
    let title: NSAttributedString
    let backgroundColor: UIColor
    let icon: Icon
    let iconTintColor: UIColor
    
    let action: (() -> Void)?
    
    init(icon: Icon, title: String, typography: TypographyProvider, theming: PlaceDetailTheming, action: (() -> Void)? = nil) {
        self.icon = icon
        self.iconTintColor = theming.cellIconTint
        self.title = NSAttributedString(string: title, attributes: typography.regularCellTitle)
        self.backgroundColor = theming.cellBackground
        self.action = action
    }
    
}
