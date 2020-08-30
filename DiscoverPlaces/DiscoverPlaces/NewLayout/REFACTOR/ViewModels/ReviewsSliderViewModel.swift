
import UIKit

struct ReviewsSliderViewModel: DetailItemViewModelType {

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
