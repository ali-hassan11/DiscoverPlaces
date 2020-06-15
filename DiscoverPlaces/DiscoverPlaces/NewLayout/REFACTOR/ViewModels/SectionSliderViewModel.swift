
import UIKit

enum SliderType: CaseIterable {
     case reviews
     case places
 }

struct SectionSliderViewModel: DetailItemViewModel {
    
    typealias Typography = DefaultTypographyProvider & PlaceDetailTypography
    
    let typography: Typography
    let theming: PlaceDetailTheming
    
    let items: [Any]
    let sectionTitle: NSAttributedString
    let sectionHeight: CGFloat
    let sliderType: SliderType
    
    init(sliderSectionItem: SliderSectionItem, typography: Typography, theming: PlaceDetailTheming) {
        self.typography = typography
        self.theming = theming
        
        switch sliderSectionItem.type {
            
        case .reviews(let reviewsItem):
            items = reviewsItem.reviews
            sectionHeight = reviewsItem.height
            sliderType = .reviews
            sectionTitle = NSAttributedString(string: reviewsItem.sectionTitle, attributes: typography.sectionHeading)
        case .nearby(let placeSliderItem):
            items = placeSliderItem.places
            sectionHeight = placeSliderItem.height
            sliderType = .places
            sectionTitle = NSAttributedString(string: placeSliderItem.sectionTitle, attributes: typography.sectionHeading)
        }
        
    }
}

//
enum SectionType {
    case reviews(ReviewSliderItem)
    case nearby(PlaceSliderItem)
}
struct SliderSectionItem {
    let type: SectionType
}
//


struct ReviewSliderItem {
    let reviews: [Review]
    let sectionTitle: String
    let height: CGFloat
    let action: (Review) -> Void
}

struct PlaceSliderItem {
    let places: [PlaceResult]
    let sectionTitle: String
    let height: CGFloat
    let action: (String) -> Void
}

