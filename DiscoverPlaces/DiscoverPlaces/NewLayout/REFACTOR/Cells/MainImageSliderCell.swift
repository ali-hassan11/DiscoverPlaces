
import UIKit

final class MainImageSliderCell: UITableViewCell, NibLoadableReusable {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pageIndicator: UISegmentedControl!
    
    @IBOutlet weak var imagesSliderContainer: UIView!
    @IBOutlet weak var starsContainer: UIView!
    
    private var imagesController: ImagesHorizontalController?
    
    func configure(using viewModel: DetailItemViewModel) {
        guard let viewModel = viewModel as? MainImageSliderViewModel else { return }
        
        configureLabels(using: viewModel)
        configureStars(using: viewModel)
        configureImageSlider(using: viewModel)
        
        pageIndicator.selectedSegmentTintColor = viewModel.pageIndicatorColor
    }
            
    private func configureStars(using viewModel: MainImageSliderViewModel) {
        guard let rating = viewModel.rating else { return }
        let starsView = StarRatingView()
        starsView.populate(with: rating, displaysNumber: true)
        
        starsContainer.addSubview(starsView)
        starsContainer.backgroundColor = .clear
        starsView.fillSuperview()
    }
    
    private func configureLabels(using viewModel: MainImageSliderViewModel) {
        placeNameLabel.attributedText = viewModel.placeName
        placeNameLabel.numberOfLines = 2
        
        distanceLabel.attributedText = viewModel.distance
    }
    
    private func configureImageSlider(using viewModel: MainImageSliderViewModel) {
        imagesController = ImagesHorizontalController(theming: viewModel.theming)
        guard let imagesController = imagesController else { return }
        imagesController.photos = viewModel.photos
        imagesSliderContainer.addSubview(imagesController.view)
        imagesSliderContainer.backgroundColor = viewModel.imagesPlaceHolderColor
        imagesController.view.fillSuperview()
    }
    
}
