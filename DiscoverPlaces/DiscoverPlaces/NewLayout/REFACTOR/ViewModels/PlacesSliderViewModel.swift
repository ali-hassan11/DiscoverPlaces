
import UIKit

struct PlacesSliderViewModel: DetailItemViewModelType {

    typealias Typography = DefaultTypographyProvider & PlaceDetailTypographyProvider

    let typography: Typography
    let theming: PlaceDetailTheming

    let places: [PlaceResult]
    let sectionTitle: NSAttributedString
    let sectionHeight: CGFloat

    let didSelectPlaceAction: ((String) -> Void)?

    init(placeSliderItem: PlaceSliderItem, typography: Typography, theming: PlaceDetailTheming) {
        self.typography = typography
        self.theming = theming

        places = placeSliderItem.places
        sectionHeight = placeSliderItem.height
        sectionTitle = NSAttributedString(string: placeSliderItem.sectionTitle, attributes: typography.sectionHeading)
        didSelectPlaceAction = placeSliderItem.action
    }
}
