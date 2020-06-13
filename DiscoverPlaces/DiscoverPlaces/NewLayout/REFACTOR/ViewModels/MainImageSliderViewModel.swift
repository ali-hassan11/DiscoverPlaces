import UIKit

struct MainImageSliderViewModel: DetailItemViewModel {
    
    typealias Typography = TypographyProvider & PlaceDetailTypography
    let theming: PlaceDetailTheming
    
    let placeName: NSAttributedString
    let distance: NSAttributedString
    let photos: [Photo]?
    let rating: Double?
    let imagesPlaceHolderColor: UIColor
    let starsFillColor: UIColor
    let starsBorderColor: UIColor
    let pageIndicatorColor: UIColor
    let pageIndicatorBackgroundColor: UIColor
        
    init(mainImageSliderItem: MainImageSliderItem, typography: Typography, theming: PlaceDetailTheming) {
        
        self.theming = theming
        self.photos = mainImageSliderItem.photos
        self.rating = mainImageSliderItem.rating
        
        self.placeName = NSAttributedString(string: mainImageSliderItem.name, attributes: typography.placeNameLargeTitle)
        self.distance = NSAttributedString(string: mainImageSliderItem.distance ?? "", attributes: typography.distanceLabel)
        
        self.imagesPlaceHolderColor = theming.imagePlaceHolder
        self.starsFillColor = theming.starFill
        self.starsBorderColor = theming.starBorder
        self.pageIndicatorColor = theming.pageIndicatorFill
        self.pageIndicatorBackgroundColor = theming.pageIndicatorBackground
    }
    
}
