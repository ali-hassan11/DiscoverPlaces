import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get }
    func start()
}

extension Coordinator {
    
    func callNumber(number: String) {
        
        let number = number.trimmingCharacters(in: .whitespacesAndNewlines)
        makeCall(with: number)
    }
    
    func makeCall(with number: String) {
        
        if let url = URL(string: "tel://\(number)")  {
            UIApplication.shared.open(url)
        } else {
            UIPasteboard.general.string = number
            navigationController.visibleViewController?.showToastAlert(title: "Number copied to clipboard!")
        }
    }
    
    func popTwoControllers() -> Void {
        let viewControllers = navigationController.viewControllers
        navigationController.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
