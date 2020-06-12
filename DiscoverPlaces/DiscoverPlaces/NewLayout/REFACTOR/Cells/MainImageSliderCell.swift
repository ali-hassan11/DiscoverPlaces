
import UIKit

final class MainImageSliderCell: UITableViewCell, NibLoadableReusable {
    
    @IBOutlet weak var ImagesSliderContainer: UIView!
    @IBOutlet weak var starsContainer: UIView!
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pageIndicator: UISegmentedControl!
    
    func configure(using viewModel: DetailItemViewModel) {
//        guard let viewModel = viewModel as? MainImageSliderViewModel else { return }
    }
    
}
