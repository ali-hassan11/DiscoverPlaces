
import UIKit

final class SectionSliderCell: UITableViewCell, NibLoadableReusable {
    
    @IBOutlet weak var reviewsHeadingLabel: UILabel!
    @IBOutlet weak var sliderControllerContainer: UIView!
    var sliderController: HorizontalSnappingController?
    @IBOutlet weak var sliderControllerHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
    func configure(using viewModel: DetailItemViewModel) {
        guard let viewModel = viewModel as? SectionSliderViewModel else { return }
        
        selectionStyle = .none
        
        configureSliderController(using: viewModel)
        reviewsHeadingLabel.attributedText = viewModel.sectionTitle
    }
    
    private func configureSliderController(using viewModel: SectionSliderViewModel) {
        
        switch viewModel.sliderType {
        case .reviews:
            add(ReviewsHorizontalController(), using: viewModel)
        case .places:
            add(PlaceGroupHorizontalController(), using: viewModel)
        }
    }
    
    private func add(_ reviewsController: ReviewsHorizontalController, using viewModel: SectionSliderViewModel) {
        let reviews = viewModel.items as? [Review]
        sliderController = reviewsController
        sliderControllerHeight.constant = viewModel.sectionHeight
        sliderControllerContainer.backgroundColor = .clear
        sliderControllerContainer.addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
        reviewsController.reviews = reviews //Dependency inject this.
    }
    
    private func add(_ placesController: PlaceGroupHorizontalController, using viewModel: SectionSliderViewModel) {
        let placeResults = viewModel.items as? [PlaceResult]
        sliderController = placesController
        sliderControllerHeight.constant = viewModel.sectionHeight
        sliderControllerContainer.backgroundColor = .clear
        sliderControllerContainer.addSubview(placesController.view)
        placesController.view.fillSuperview()
        placesController.results = placeResults //Dependency inject this.
    }
    
    
}
