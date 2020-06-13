import UIKit

struct DetailItem {
    
    let type: DetailType
    let action: (() -> Void)?
    
    enum DetailType  {
        case mainImagesSlider(MainImageSliderViewModel)
        case regular(RegularDetailViewModel)
        case actionButtons(DetailActionsViewModel)
        case reviews(ReviewSliderViewModel)
        case morePlaces
        case googleCell
        case separator
     }
}
