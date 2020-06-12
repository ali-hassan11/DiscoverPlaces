import UIKit

class DetailsViewModel {
    
    var result: PlaceDetailResult?
    private var items = [DetailItem]()
    let dispatchGroup = DispatchGroup()
    
    init(placeId: String, location: LocationItem, typography: PlaceDetailTypography, theming: PlaceDetailTheming) {
        
        fetchPlaceData(for: placeId, typography: typography, theming: theming)
  
    }
    
    private static func vicinity(using vicinity: String, typography: PlaceDetailTypography, theming: PlaceDetailTheming) -> DetailItem {
        let viewModel = RegularDetailViewModel(icon: .mapPin, title: vicinity, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: nil)
    }
    
    private static func phoneNumber(using phoneNumber: String, typography: PlaceDetailTypography, theming: PlaceDetailTheming) -> DetailItem {
        let viewModel = RegularDetailViewModel(icon: .phone, title: phoneNumber, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: nil)
    }
    
    private static func website(using webAddress: String, typography: PlaceDetailTypography, theming: PlaceDetailTheming) -> DetailItem {
         let viewModel = RegularDetailViewModel(icon: .browser, title: "Website", typography: typography, theming: theming)
         return DetailItem(type: .regular(viewModel), action: nil) //Use webAdress for action
    }
}

//MARK: FetchData
extension DetailsViewModel {
    
    func fetchPlaceData(for id: String, typography: PlaceDetailTypography, theming: PlaceDetailTheming) {

        guard Reachability.isConnectedToNetwork() else { return }
        
        Service.shared.fetchPlaceDetails(placeId: id, fields: Constants.placeDetailFields) {  [weak self] (placeResponse, error) in
            
            if let error = error {
                print("Falied to fetch: ", error)
                return
            }
            
            //success
            guard let placeResponse = placeResponse else {
                print("No results?")
                return
            }
            
            let results = placeResponse.result
            var items = [DetailItem]()
            
            if let vicinity = results?.vicinity {
                items.append(Self.vicinity(using: vicinity,
                                           typography: typography,
                                           theming: theming))
            }
            
            if let phoneNumber = results?.international_phone_number {
                items.append(Self.phoneNumber(using: phoneNumber,
                                              typography: typography,
                                              theming: theming))
            }
            
            if let webAdress = results?.website {
                
                items.append(Self.website(using: webAdress,
                                          typography: typography,
                                          theming: theming))
                
            } else if let googleUrl = results?.url {
                
                items.append(Self.website(using: googleUrl,
                                          typography: typography,
                                          theming: theming))
            }
            
            self?.items = items
        }
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
