import UIKit

extension UINavigationItem {
    
    func hideBackButtonText() {
        backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}
