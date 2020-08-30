import UIKit

protocol DefaultThemingProvider {
    
    var background: UIColor { get }
    var cellBackground: UIColor { get }
    var imagePlaceHolder: UIColor { get }
    var starFill: UIColor { get }
    var starBorder: UIColor { get }
    var pageIndicatorFill: UIColor { get }
    var pageIndicatorBackground: UIColor { get }
    
}

class DefaultTheming: DefaultThemingProvider {
    var background: UIColor = .systemBackground
    let cellBackground: UIColor = .systemBackground
    let imagePlaceHolder: UIColor = .secondarySystemBackground
    let starFill: UIColor = .systemPink
    let starBorder: UIColor = .systemPink
    let pageIndicatorFill: UIColor = .systemPink
    let pageIndicatorBackground: UIColor = .quaternarySystemFill
}

//MARK: Place Detail
protocol PlaceDetailTheming: DefaultThemingProvider {
    var cellIconTint: UIColor { get }
    var actionButtonBackground: UIColor { get }
    var actionButtonTint: UIColor { get }
}

extension DefaultTheming: PlaceDetailTheming {
    var cellIconTint: UIColor { return .label }
    var actionButtonBackground: UIColor { return .systemPink }
    var actionButtonTint: UIColor { return .white }
    
}
