import UIKit

struct MainImageSliderViewModel: DetailItemViewModelType {
    
    typealias Typography = DefaultTypographyProvider & PlaceDetailTypographyProvider
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
    
    private var mainImageSliderItem: MainImageSliderItem
    private var typography: Typography
        
    init(mainImageSliderItem: MainImageSliderItem, typography: Typography, theming: PlaceDetailTheming) {
        
        self.theming = theming
        self.typography = typography
        self.mainImageSliderItem = mainImageSliderItem
        
        self.photos = mainImageSliderItem.photos
        self.rating = mainImageSliderItem.rating
        
        self.placeName = NSAttributedString(string: mainImageSliderItem.name, attributes: typography.placeNameLargeTitle)
        self.distance = NSAttributedString(string: String(mainImageSliderItem.distance), attributes: typography.distanceLabel)
        
        self.imagesPlaceHolderColor = theming.imagePlaceHolder
        self.starsFillColor = theming.starFill
        self.starsBorderColor = theming.starBorder
        self.pageIndicatorColor = theming.pageIndicatorFill
        self.pageIndicatorBackgroundColor = theming.pageIndicatorBackground
    }
    
    func distanceAttributedString() -> NSAttributedString {
        let distance = mainImageSliderItem.distance.inUnits()
        let distanceString = String(distance)
        return NSAttributedString(string: distanceString, attributes: typography.distanceLabel)
    }
}
