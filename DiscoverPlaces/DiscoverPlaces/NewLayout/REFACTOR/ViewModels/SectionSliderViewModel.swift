//
//import UIKit
//
//enum SliderAction {
//     case reviews(((Review) -> Void)?)
//     case places(((String) -> Void)?)
// }
//
//struct SectionSliderViewModel: DetailItemViewModel {
//
//    typealias Typography = DefaultTypographyProvider & PlaceDetailTypographyProvider
//
//    let typography: Typography
//    let theming: PlaceDetailTheming
//
//    let items: [Any]
//    let sectionTitle: NSAttributedString
//    let sectionHeight: CGFloat
//
//    let didSelectItemAction: SliderAction
//
//    init(sliderSectionItem: SliderSectionItem, typography: Typography, theming: PlaceDetailTheming) {
//        self.typography = typography
//        self.theming = theming
//
//        switch sliderSectionItem.type {
//
//        case .reviews(let reviewsItem):
//            items = reviewsItem.reviews
//            sectionHeight = reviewsItem.height
//            sectionTitle = NSAttributedString(string: reviewsItem.sectionTitle, attributes: typography.sectionHeading)
//            didSelectItemAction = .reviews(reviewsItem.action)
//        case .nearby(let placeSliderItem):
//            items = placeSliderItem.places
//            sectionHeight = placeSliderItem.height
//            sectionTitle = NSAttributedString(string: placeSliderItem.sectionTitle, attributes: typography.sectionHeading)
//            didSelectItemAction = .places(placeSliderItem.action)
//        }
//    }
//
//}


import UIKit

struct ReviewsSliderViewModel: DetailItemViewModel {

    typealias Typography = DefaultTypographyProvider & PlaceDetailTypographyProvider

    let typography: Typography
    let theming: PlaceDetailTheming

    let reviews: [Review]
    let sectionTitle: NSAttributedString
    let sectionHeight: CGFloat

    let didSelectReviewAction: ((Review) -> Void)?

    init(reviewSliderItem: ReviewSliderItem, typography: Typography, theming: PlaceDetailTheming) {
        self.typography = typography
        self.theming = theming

        reviews = reviewSliderItem.reviews
        sectionHeight = reviewSliderItem.height
        sectionTitle = NSAttributedString(string: reviewSliderItem.sectionTitle, attributes: typography.sectionHeading)
        didSelectReviewAction = reviewSliderItem.action
    }
}

struct PlacesSliderViewModel: DetailItemViewModel {

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
