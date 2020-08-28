//
//import UIKit
//
////TODO: Separate review and more places to separate cells and view models
//final class SectionSliderCell: UITableViewCell, NibLoadableReusable, DetailCellConfigurable {
//
//    @IBOutlet weak var reviewsHeadingLabel: UILabel!
//    @IBOutlet weak var sliderControllerContainer: UIView!
//
//    var sliderController: HorizontalSnappingController?
//
//    @IBOutlet weak var sliderControllerHeight: NSLayoutConstraint!
//
//    func configure(using viewModel: DetailItemViewModel) {
//        guard let viewModel = viewModel as? SectionSliderViewModel else { return }
//
//        sliderControllerHeight.constant = viewModel.sectionHeight
//
//        selectionStyle = .none
//
//        configureSliderController(using: viewModel)
//        reviewsHeadingLabel.attributedText = viewModel.sectionTitle
//    }
//
//    private func configureSliderController(using viewModel: SectionSliderViewModel) {
//
//        switch viewModel.didSelectItemAction {
//        case .reviews(let didSelecthandler):
//            let reviewsController = ReviewsHorizontalController(reviews: viewModel.items as? [Review], didSelectHandler: didSelecthandler)
//            add(reviewsController, using: viewModel)
//        case .places(let didSelectHandler):
//            let placeGroupController = PlaceGroupHorizontalController(results: viewModel.items as? [PlaceResult], didSelectHandler: didSelectHandler)
//            add(placeGroupController, using: viewModel)
//        }
//
//        sliderControllerContainer.backgroundColor = .clear
//    }
//
//    private var shouldAddReviews = true
//    private func add(_ reviewsController: ReviewsHorizontalController, using viewModel: SectionSliderViewModel) {
//        guard shouldAddReviews == true else { return }
//        shouldAddReviews = false
//        removeSliderContainerSubviews()
//
//        sliderController = reviewsController
//        sliderControllerContainer.addSubview(reviewsController.view)
//        reviewsController.view.fillSuperview()
//    }
//
//    private var shouldAddMorePlaces = true
//    private func add(_ placesController: PlaceGroupHorizontalController, using viewModel: SectionSliderViewModel) {
//        guard shouldAddMorePlaces == true else { return }
//        shouldAddMorePlaces = false
//        removeSliderContainerSubviews()
//
//        sliderController = placesController
//        sliderControllerContainer.addSubview(placesController.view)
//        placesController.view.fillSuperview()
//    }
//
//    private func removeSliderContainerSubviews() {
//        sliderControllerContainer.subviews.forEach { $0.removeFromSuperview() }
//    }
//}
//
//
