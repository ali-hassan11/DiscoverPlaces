import UIKit

class DetailsViewModel: NSObject {
    
    private var items = [DetailItem]()
    
    private let typography: PlaceDetailTypography
    private let theming: PlaceDetailTheming
    private let placeId: String
    private let location: LocationItem
    
    private var result: PlaceDetailResult?
    
    init(placeId: String, location: LocationItem, typography: PlaceDetailTypography, theming: PlaceDetailTheming) {
        self.placeId = placeId
        self.location = location
        self.typography = typography
        self.theming = theming
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
    
    func fetchPlaceData(completion: @escaping (Error?) -> Void) {
        
        guard Reachability.isConnectedToNetwork() else { return }
        
        Service.shared.fetchPlaceDetails(placeId: placeId, fields: Constants.placeDetailFields) {  [weak self] (placeResponse, error) in
            
            guard let self = self else { return }
            
            if let error = error {
                print("Falied to fetch: ", error)
                completion(error)
                return
            }
            
            //success
            guard let placeResponse = placeResponse else {
                print("No results?")
                completion(error)
                return
            }
            //
            
            let results = placeResponse.result
            var items = [DetailItem]()
            
            if let vicinity = results?.vicinity {
                items.append(Self.vicinity(using: vicinity,
                                           typography: self.typography,
                                           theming: self.theming))
            }
            
            if let phoneNumber = results?.international_phone_number {
                items.append(Self.phoneNumber(using: phoneNumber,
                                              typography: self.typography,
                                              theming: self.theming))
            }
            
            if let webAdress = results?.website {
                
                items.append(Self.website(using: webAdress,
                                          typography: self.typography,
                                          theming: self.theming))
                
            } else if let googleUrl = results?.url {
                
                items.append(Self.website(using: googleUrl,
                                          typography: self.typography,
                                          theming: self.theming))
            }
            
            self.items = items
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}


extension DetailsViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        switch item.type {
        case .regular(let regularDetailViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RegularCell.self), for: indexPath) as? RegularCell else {
                return UITableViewCell()
            }
            cell.configure(using: regularDetailViewModel)
            return cell
        default:
            fatalError()
        }
    }
    
}

// MARK: Public API
extension DetailsViewModel {
    
    public func numberOfRows() -> Int {
        return items.count
    }
    
    public func itemForRow(at indexPath: IndexPath) -> DetailItem {
        return items[indexPath.row]
    }
    
}
