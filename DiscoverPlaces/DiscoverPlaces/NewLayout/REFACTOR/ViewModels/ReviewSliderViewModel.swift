
import UIKit

struct ReviewSliderViewModel: DetailItemViewModel {
    
    typealias Typography = TypographyProvider & PlaceDetailTypography
    
    let typography: Typography
    let theming: PlaceDetailTheming
    
    let reviews: [Review]
    
    let sectionHeadingTitle: NSAttributedString
    
    init(reviews: [Review], typography: Typography, theming: PlaceDetailTheming) {
        self.typography = typography
        self.theming = theming
        
        self.reviews = reviews
        self.sectionHeadingTitle = NSAttributedString(string: "Reviews", attributes: typography.sectionHeading)
    }
    
}
