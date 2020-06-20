
import UIKit

enum SliderAction {
     case reviews(((Review) -> Void)?)
     case places(((String) -> Void)?)
 }

struct SectionSliderViewModel: DetailItemViewModel {
    
    typealias Typography = DefaultTypographyProvider & PlaceDetailTypographyProvider
    
    let typography: Typography
    let theming: PlaceDetailTheming
    
    let items: [Any]
    let sectionTitle: NSAttributedString
    let sectionHeight: CGFloat
    
    let didSelectItemAction: SliderAction

    init(sliderSectionItem: SliderSectionItem, typography: Typography, theming: PlaceDetailTheming) {
        self.typography = typography
        self.theming = theming
        
        switch sliderSectionItem.type {
            
        case .reviews(let reviewsItem):
            items = reviewsItem.reviews
            sectionHeight = reviewsItem.height
            sectionTitle = NSAttributedString(string: reviewsItem.sectionTitle, attributes: typography.sectionHeading)
            didSelectItemAction = .reviews(reviewsItem.action)
        case .nearby(let placeSliderItem):
            items = placeSliderItem.places
            sectionHeight = placeSliderItem.height
            sectionTitle = NSAttributedString(string: placeSliderItem.sectionTitle, attributes: typography.sectionHeading)
            didSelectItemAction = .places(placeSliderItem.action)
        }
    }
    
}
