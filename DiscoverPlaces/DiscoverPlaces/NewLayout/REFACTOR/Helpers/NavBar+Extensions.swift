import UIKit

extension UINavigationBar {
    func makeTransparent(withTint tint: UIColor = .systemPink) {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        tintColor = tint
        titleTextAttributes = [.foregroundColor: tint]
        shadowImage = UIImage()
    }
}
