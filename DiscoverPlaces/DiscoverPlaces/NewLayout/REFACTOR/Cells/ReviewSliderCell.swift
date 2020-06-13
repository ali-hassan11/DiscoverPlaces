
import UIKit

final class ReviewSliderCell: UITableViewCell, NibLoadableReusable {
    
    @IBOutlet weak var reviewsHeadingLabel: UILabel!
    @IBOutlet weak var reviewsControllerContainer: UIView!
    var reviewsController = ReviewsHorizontalController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewsControllerContainer.addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    
    func configure(using viewModel: DetailItemViewModel) {
        guard let viewModel = viewModel as? ReviewSliderViewModel else { return }
        
        selectionStyle = .none
        
        reviewsController.reviews = viewModel.reviews
        
        reviewsHeadingLabel.attributedText = viewModel.sectionHeadingTitle
        reviewsControllerContainer.backgroundColor = .clear
        
    }
    
}
