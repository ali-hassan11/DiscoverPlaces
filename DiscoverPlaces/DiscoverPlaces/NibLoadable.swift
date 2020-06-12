
import Foundation
import UIKit

public protocol NibLoadable where Self: UIView {
	static func loadFromNib() -> UIView?
	static func loadFromNib(withName name: String) -> UIView?
    static func nib() -> UINib?
}

public extension NibLoadable {
    static func loadFromNib() -> UIView? {

		let viewClassName = String(describing: self)
		return loadFromNib(withName: viewClassName)
	}

    static func loadFromNib(withName name: String) -> UIView? {

        guard let views = self.nib(named: name)?.instantiate(withOwner: nil, options: nil) else {
            return nil
        }

        return views.first as? UIView
    }

    static func nib() -> UINib? {

        return self.nib(named: String(describing: self))
    }

    static func nib(named name: String) -> UINib? {
		
        let bundle = self.bundle(forNibNamed: name)

        return UINib(nibName: name, bundle: bundle)
    }

    private static func bundle(forNibNamed name: String) -> Bundle {

        if let bundle = BundleHelper<NoFramework>.bundleForNib(named: name) {
            return bundle
        }

        return Bundle(for: self)
    }
}

public typealias NibLoadableReusable = (NibLoadable & ReuseIdentifiable)
