import UIKit

protocol ThemingProvider {
    
    var cellBackground: UIColor { get }
    var cellIconTint: UIColor { get }
    
}

final class PlaceDetailTheming: ThemingProvider {
    
    let cellBackground: UIColor = .systemBackground
    let cellIconTint: UIColor = .label
    
}
