import UIKit
import Foundation

struct RegularDetailViewModel {
    
    let icon: Icon
    let title: NSAttributedString
    let backgroundColor: UIColor
    
    
    init(icon: Icon, title: String, typography: TypographyProvider, theming: ThemingProvider) {
        self.icon = icon
        self.title = NSAttributedString(string: title, attributes: typography.regularCellTitle)
        self.backgroundColor = theming.cellBackground
    }
    
}
