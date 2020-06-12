
import Foundation
import UIKit

/// Provides a simple means to get a re-use identifier for things which use them.
/// Most typically this will be `UICollectionViweCell` or `UITableViewCell`
public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifiable where Self: UIView {
    static var reuseIdentifier: String { return String(describing: self) }
}
