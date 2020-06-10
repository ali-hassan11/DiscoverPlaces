import UIKit

struct DetailsViewModel {
    
    private var items = [DetailItem]()
    
    init(placeDetails: PlaceDetailResponse, typography: TypographyProvider, theming: ThemingProvider) {
        
        var items = [DetailItem]()
        
        guard let results = placeDetails.result else { return }
        
        guard let vicinity = results.vicinity else { return }
        items.append(Self.regularCellDetail(using: vicinity, typography: typography, theming: theming))
        
        //Dummy Cells to fill up tableView
        items.append(Self.regular2(using: vicinity, typography: typography, theming: theming))
        items.append(Self.regular3(using: vicinity, typography: typography, theming: theming))
        
        self.items = items
    }
    
    private static func regularCellDetail(using vicinity: String, typography: TypographyProvider, theming: ThemingProvider) -> DetailItem {
        let viewModel = RegularDetailViewModel(icon: .mapPin, title: vicinity, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: nil)
    }
    
    private static func regular2(using vicinity: String, typography: TypographyProvider, theming: ThemingProvider) -> DetailItem {
        let viewModel = RegularDetailViewModel(icon: .phone, title: "Title2", typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: nil)
    }
    
    private static func regular3(using vicinity: String, typography: TypographyProvider, theming: ThemingProvider) -> DetailItem {
        let viewModel = RegularDetailViewModel(icon: .browser, title: "Title3", typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: nil)
    }
    
}

// MARK: Public API
extension DetailsViewModel {
    
    //expose tableView methods
    public func numberOfRows() -> Int {
        return items.count
    }
    
    public func itemForRow(at indexPath: IndexPath) -> DetailItem {
        return items[indexPath.row]
    }
    
}
