
import UIKit

final class MainImageSliderCell: UITableViewCell, NibLoadableReusable {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pageIndicator: UISegmentedControl!
    
    @IBOutlet weak var imagesSliderContainer: UIView!
    @IBOutlet weak var starsContainer: UIView!
    @IBOutlet weak var gradientView: UIView!
    
    private var imagesController: ImagesHorizontalController?
    
    func configure(using viewModel: DetailItemViewModel) {
        
        guard let viewModel = viewModel as? MainImageSliderViewModel else { return }
    
        configureLabels(using: viewModel)
        configureStars(using: viewModel)
        configureImageSlider(using: viewModel)
        configurePageIndicator(using: viewModel)
        configureGradient()
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

        imagesController.didScrollImagesController = { [weak self] nearestPage in
            self?.pageIndicator.selectedSegmentIndex = nearestPage
        }
    }
    
    private func configureGradient() {
        gradientView.backgroundColor = .clear
        gradientView.isUserInteractionEnabled = false
        addGradient(firstColor: .clear, secondColor: .black, view: gradientView, start: 0.69, end: 0.96)
    }
    
    private func configurePageIndicator(using viewModel: MainImageSliderViewModel) {
        
        guard let count = viewModel.photos?.count else { return }
        populatePageIndicator(with: count)
        
        pageIndicator.isUserInteractionEnabled = false
        pageIndicator.backgroundColor = viewModel.pageIndicatorBackgroundColor
        pageIndicator.selectedSegmentTintColor = viewModel.pageIndicatorColor
        
        pageIndicator.selectedSegmentIndex = 0
    }
    
    private func populatePageIndicator(with count: Int) {
        pageIndicator.removeAllSegments()
        
        if count == 1 { return }
        
        for i in 1...count {
            pageIndicator.insertSegment(withTitle: nil, at: i, animated: true)
        }
    }
}
