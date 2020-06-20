
import UIKit

final class SectionSliderCell: UITableViewCell, NibLoadableReusable, DetailCellConfigurable {
    
    @IBOutlet weak var reviewsHeadingLabel: UILabel!
    @IBOutlet weak var sliderControllerContainer: UIView!
    var sliderController: HorizontalSnappingController?
    @IBOutlet weak var sliderControllerHeight: NSLayoutConstraint!
        
    func configure(using viewModel: DetailItemViewModel) {
        guard let viewModel = viewModel as? SectionSliderViewModel else { return }
        
        selectionStyle = .none
        
        configureSliderController(using: viewModel)
        reviewsHeadingLabel.attributedText = viewModel.sectionTitle
    }
    
    private func configureSliderController(using viewModel: SectionSliderViewModel) {
        
        switch viewModel.didSelectItemAction {
        case .reviews(let didSelecthandler):
            let reviewsController = ReviewsHorizontalController(didSelectHandler: didSelecthandler)
            add(reviewsController, using: viewModel)
        case .places(let didSelectHandler):
            let placeGroupController = PlaceGroupHorizontalController(didSelectHandler: didSelectHandler)
            placeGroupController.didSelectPlaceHandler = didSelectHandler
            add(placeGroupController, using: viewModel)
        }
    }
    
    private var shouldAddReviews = true
    private func add(_ reviewsController: ReviewsHorizontalController, using viewModel: SectionSliderViewModel) {
        guard shouldAddReviews == true else { return }
        shouldAddReviews = false
        removeSliderContainerSubviews()

        let reviews = viewModel.items as? [Review]
        sliderController = reviewsController
        sliderControllerHeight.constant = viewModel.sectionHeight
        sliderControllerContainer.backgroundColor = .clear
        sliderControllerContainer.addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
        reviewsController.reviews = reviews //Dependency inject this.
        
//        reviewsController.didSelectHandler = viewModel.didSelectHandler
    }
    
    private var shouldAddMorePlaces = true
    private func add(_ placesController: PlaceGroupHorizontalController, using viewModel: SectionSliderViewModel) {
        guard shouldAddMorePlaces == true else { return }
        shouldAddMorePlaces = false
        removeSliderContainerSubviews()
        
        let placeResults = viewModel.items as? [PlaceResult]
        sliderController = placesController
        sliderControllerHeight.constant = viewModel.sectionHeight
        sliderControllerContainer.backgroundColor = .clear
        sliderControllerContainer.addSubview(placesController.view)
        placesController.view.fillSuperview()
        placesController.results = placeResults //Dependency inject this.
    }
    
    private func removeSliderContainerSubviews() {
        sliderControllerContainer.subviews.forEach { $0.removeFromSuperview() }
    }
}
