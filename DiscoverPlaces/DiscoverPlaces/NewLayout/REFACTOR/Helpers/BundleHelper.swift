
import Foundation

protocol FrameworkName {
    static var defaultName: String { get }
}

internal class IndexKitFramework: FrameworkName {
    static var defaultName: String { return "IndexKit" }
}

internal class NoFramework: FrameworkName {
    static var defaultName: String { return "" }
}

internal class BundleHelper<Framework: FrameworkName> {

    internal static var frameworkName: String {

        let fallbackName = Framework.defaultName

        let bundle = Bundle(for: self)
        guard let infoDictionary = bundle.infoDictionary,
            let frameworkName = infoDictionary["CFBundleName"] as? String else {
            assertionFailure("Bundle infoDictionary not found - using \(fallbackName) in Production")
            return fallbackName
        }

        return frameworkName
    }

    internal static var bundleExtension: String {
        return "bundle"
    }

    internal static var nibType: String {
        return "nib"
    }

    internal class func bundle() -> Bundle {

        return BundleHelper.bundleResource(for: BundleHelper.bundleExtension)
    }

    internal class func bundleForNib(named name: String) -> Bundle? {

        let nibBundle = BundleHelper.bundle()

        if nibBundle.path(forResource: name, ofType: nibType) == nil { return nil }

        return nibBundle
    }
}

extension BundleHelper {

    private class func bundleResource(for ext: String) -> Bundle {

        let podBundle = Bundle(for: self)
        var bundle: Bundle = podBundle

        if let frameworkURL = podBundle.url(forResource: self.frameworkName, withExtension: ext),
            let bundleURL = Bundle(url: frameworkURL) {
            bundle = bundleURL
        }

        return bundle
    }
}
