import UIKit

final class RegularCell: UITableViewCell, NibLoadableReusable, DetailCellConfigurable {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var disclosureIndicatorImageView: UIImageView!
    
    func configure(using viewModel: DetailItemViewModelType) {
        guard let viewModel = viewModel as? RegularDetailViewModel else { return }
        
        titleLabel.attributedText = viewModel.title

        iconImageView.image = UIImage(systemName: viewModel.icon.name)
        iconImageView.tintColor = viewModel.iconTintColor
        
        disclosureIndicatorImageView.image = UIImage(systemName: Icon.disclosureIndicator.name)
        disclosureIndicatorImageView.tintColor = viewModel.iconTintColor
        
        backgroundColor = viewModel.backgroundColor
    }
}
