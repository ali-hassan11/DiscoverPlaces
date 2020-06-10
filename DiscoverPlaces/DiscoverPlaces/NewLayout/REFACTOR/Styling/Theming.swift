import UIKit

protocol ThemingProvider {
    
    var cellBackground: UIColor { get }
    
}

final class DefaultTheming: ThemingProvider {
    
    let cellBackground = UIColor.systemBackground
    
}
