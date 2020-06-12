import UIKit
import Foundation

struct RegularDetailViewModel {
    
    let title: NSAttributedString
    let backgroundColor: UIColor
    let icon: Icon
    let iconTintColor: UIColor
    
    init(icon: Icon, title: String, typography: TypographyProvider, theming: PlaceDetailTheming) {
        self.icon = icon
        self.iconTintColor = theming.cellIconTint
        self.title = NSAttributedString(string: title, attributes: typography.regularCellTitle)
        self.backgroundColor = theming.cellBackground
    }
    
}
