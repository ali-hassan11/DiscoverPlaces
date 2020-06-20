
import UIKit

enum SliderSectionType {
    case reviews(ReviewSliderItem)
    case nearby(PlaceSliderItem)
}
struct SliderSectionItem {
    let type: SliderSectionType
}

struct ReviewSliderItem {
    let reviews: [Review]
    let sectionTitle: String
    let height: CGFloat
    let action: ((Review) -> Void)?
}

struct PlaceSliderItem {
    let places: [PlaceResult]
    let sectionTitle: String
    let height: CGFloat
    let action: ((String) -> Void)?
}
