
import UIKit

final class MainImageSliderCell: UITableViewCell, NibLoadableReusable {
    
    var imagesController: ImagesHorizontalController?
    @IBOutlet weak var imagesSliderContainer: UIView!
    
    @IBOutlet weak var starsContainer: UIView!
//    let starsView: StarRatingView
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pageIndicator: UISegmentedControl!
    
    func configure(using viewModel: DetailItemViewModel) {
        guard let viewModel = viewModel as? MainImageSliderViewModel else { return }
        
        placeNameLabel.attributedText = viewModel.placeName
        placeNameLabel.numberOfLines = 2
        
        distanceLabel.attributedText = viewModel.distance
        
        pageIndicator.selectedSegmentTintColor = viewModel.pageIndicatorColor
        
        imagesSliderContainer.backgroundColor = viewModel.imagesPlaceHolderColor
        
        imagesController = ImagesHorizontalController(theming: viewModel.theming)
        guard let imagesController = imagesController else { return }
        imagesController.photos = viewModel.photos
        imagesSliderContainer.addSubview(imagesController.view)
        imagesController.view.fillSuperview()
    }
    
}
