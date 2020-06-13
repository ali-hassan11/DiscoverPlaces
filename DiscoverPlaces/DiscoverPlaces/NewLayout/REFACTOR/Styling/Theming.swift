import UIKit

protocol ThemingProvider {
    
    var cellBackground: UIColor { get }
    var cellIconTint: UIColor { get }
    var imagePlaceHolder: UIColor { get }
    var starFill: UIColor { get }
    var starBorder: UIColor { get }
    var pageIndicatorFill: UIColor { get }
    var pageIndicatorBackground: UIColor { get }
    
}

final class PlaceDetailTheming: ThemingProvider {

    let cellBackground: UIColor = .systemBackground
    let cellIconTint: UIColor = .label
    let imagePlaceHolder: UIColor = .secondarySystemBackground
    let starFill: UIColor = .systemPink
    let starBorder: UIColor = .systemPink
    let pageIndicatorFill: UIColor = .systemPink
    let pageIndicatorBackground: UIColor = .quaternarySystemFill
    
}
