
import UIKit

final class GoogleCell: UITableViewCell, DetailCellConfigurable, NibLoadableReusable {
    
    @IBOutlet weak var googleImageView: UIImageView!
    
    func configure(using viewModel: DetailItemViewModel) {
        let image = UIImage(named: "googleLogo")
        googleImageView.image = image
        googleImageView.contentMode = .scaleAspectFit
    }
}

//final class GoogleFooterView: UIView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        let googleImageView = UIImageView(image: UIImage(imageLiteralResourceName: "googleLogo"))
//        addSubview(googleImageView)
//        googleImageView.centerXInSuperview()
//        googleImageView.constrainWidth(constant: 150)
//        googleImageView.constrainHeight(constant: 65)
//        googleImageView.anchor(top: topAnchor,
//                               leading: nil,
//                               bottom: bottomAnchor,
//                               trailing: nil,
//                               padding: .init(top: 8, left: 0, bottom: 0, right: 8))
//        googleImageView.contentMode = .scaleAspectFit
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
