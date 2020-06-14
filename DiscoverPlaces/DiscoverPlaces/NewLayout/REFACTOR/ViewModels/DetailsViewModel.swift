import UIKit

final class DetailsViewModel: NSObject {
    
    private var items: [DetailItem] = []
    
    typealias Typography = TypographyProvider & PlaceDetailTypography
    private let typography: Typography
    private let theming: PlaceDetailTheming
    
    private let placeId: String
    private let location: LocationItem
    
    private var result: PlaceDetailResult?
    
    init(placeId: String, location: LocationItem, typography: Typography, theming: PlaceDetailTheming) {
        self.placeId = placeId
        self.location = location
        self.typography = typography
        self.theming = theming
    }
}

//MARK: FetchData
extension DetailsViewModel {
    
    func fetchPlaceData(completion: @escaping (Error?) -> Void) {
        
        Service.shared.fetchPlaceDetails(placeId: placeId, fields: Constants.placeDetailFields) {  [weak self] (placeResponse, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Falied to fetch: ", error)
                completion(error)
                return
            }
            
            //success
            guard let result = placeResponse?.result else {
                print("No results?")
                completion(error)
                return
            }
            
            self.populateDetailItems(with: result, completion: completion)
        }
    }
    
    private func populateDetailItems(with result: PlaceDetailResult, completion: @escaping (Error?) -> Void) {
        var items = [DetailItem]()
        
        //Photos
        if let photos = result.photos {
            
            let distance = result.geometry?.distanceString(from: location.actualUserLocation ?? location.selectedLocation)
            
            let mainImagesSliderItem = MainImageSliderItem(name: result.name, rating: result.rating, distance: distance, photos: photos)
            items.append(Self.mainImageSlider(using: mainImagesSliderItem,
                                              typography: typography,
                                              theming: theming))
        }
        
        //Regular Cells
        if let vicinity = result.vicinity {
            items.append(Self.vicinity(using: vicinity,
                                       typography: self.typography,
                                       theming: self.theming))
        }
        
        if let openingHours = result.opening_hours?.weekdayText {
            items.append(Self.openingHours(using: openingHours,
                                           typography: self.typography,
                                           theming: self.theming))
        }
        
        if let phoneNumber = result.international_phone_number {
            items.append(Self.phoneNumber(using: phoneNumber,
                                          typography: self.typography,
                                          theming: self.theming))
        }
        
        if let webAdress = result.website {
            items.append(Self.website(using: webAdress,
                                      typography: self.typography,
                                      theming: self.theming))
        } else if let googleUrl = result.url {
            items.append(Self.website(using: googleUrl,
                                      typography: self.typography,
                                      theming: self.theming))
        }
        
        //Actions
        items.append(Self.actions(placeId: placeId,
                                  typography: typography,
                                  theming: theming))
        
        //Reviews
        if let reviews = result.reviews {
        items.append(Self.reviews(reviews: reviews,
                                  typography: typography,
                                  theming: theming))
        }
        
        #warning("FIX")
        if let location = result.geometry?.location {
            fetchMorePlacesData(near: location, items: items, completion: completion)
        }
    }
    
    func fetchMorePlacesData(near location: Location, items: [DetailItem], completion: @escaping (Error?) -> Void) {
        
        Service.shared.fetchNearbyPlaces(location: location, radius: 3000) { [weak self] (response, error) in
            guard let self = self else {
                completion(nil)
                return
            }
            if let error = error {
                print("Failed to fetch places: ", error)
                return
            }
            
            //success
            guard let results = response?.results else {
                print("No results?")
                return
            }
            
            let filteredResults = SearchResponseFilter().morePlacesResults(from: results)
            
            var items = items
            
            items.append(Self.nearby(places: filteredResults,
                                     typography: self.typography,
                                     theming: self.theming))
            
            self.items = items
            DispatchQueue.main.async {
                completion(nil)
            }
            
        }
    }
}


//MARK: TableView DataSource
extension DetailsViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        switch item.type {
        case .regular(let regularDetailViewModel):
            return regularDetailCell(at: indexPath, tableView: tableView, viewModel: regularDetailViewModel)
        case .mainImagesSlider(let mainImageSliderViewModel):
            return mainImageSliderCell(at: indexPath, tableView: tableView, viewModel: mainImageSliderViewModel)
        case .actionButtons(let actionsViewModel):
            return actionsCell(at: indexPath, tableView: tableView, viewModel: actionsViewModel)
        case .reviews(let reviewSliderViewModel):
            return sectionSliderCell(at: indexPath, tableView: tableView, viewModel: reviewSliderViewModel)
        case .morePlaces(let morePlacesViewmodel):
            return configureCell(cellType: SectionSliderCell.self, at: indexPath, tableView: tableView, viewModel: morePlacesViewmodel)
        case .googleFooter:
            return googleCell(at: indexPath, tableView: tableView)
        }
    }
}

//MARK: TableView Delegate
extension DetailsViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        item.action?()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: Configure Cell Helpers
extension DetailsViewModel {

    //Make into 1 method for all
    private func regularDetailCell(at indexPath: IndexPath, tableView: UITableView, viewModel: RegularDetailViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RegularCell.reuseIdentifier, for: indexPath) as? RegularCell else {
            return UITableViewCell()
        }
        cell.configure(using: viewModel)
        return cell
    }
    
    private func mainImageSliderCell(at indexPath: IndexPath, tableView: UITableView, viewModel: MainImageSliderViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainImageSliderCell.reuseIdentifier, for: indexPath) as? MainImageSliderCell else {
            return UITableViewCell()
        }
        cell.configure(using: viewModel)
        return cell
    }
    
    private func actionsCell(at indexPath: IndexPath, tableView: UITableView, viewModel: DetailActionsViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailActionsCell.reuseIdentifier, for: indexPath) as? DetailActionsCell else {
            return UITableViewCell()
        }
        cell.configure(using: viewModel)
        return cell
    }
    
    private func googleCell(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoogleCell.reuseIdentifier, for: indexPath) as? GoogleCell else {
            return UITableViewCell()
        }
        cell.configure()
        return cell
    }
    
}

//MARK: Configure Detail Item Methods
extension DetailsViewModel {
    
    private static func mainImageSlider(using mainImageSliderItem: MainImageSliderItem, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        
        let viewModel = MainImageSliderViewModel(mainImageSliderItem: mainImageSliderItem, typography: typography, theming: theming)
        return DetailItem(type: .mainImagesSlider(viewModel), action: nil)
    }
    
    private static func vicinity(using vicinity: String, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let action: () -> Void = {
            print("Open Maps")
        }
        let viewModel = RegularDetailViewModel(icon: .mapPin, title: vicinity, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: action)
    }
    
    private static func openingHours(using openingHours: [String], typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let action: () -> Void = {
            print("Open Opening Hours")
        }
        let todaysOpeningHoursText = todayOpeningHours(openingHours: openingHours)
        
        let viewModel = RegularDetailViewModel(icon: .time, title: todaysOpeningHoursText, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: action)
    }
    
    private static func phoneNumber(using phoneNumber: String, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let action: () -> Void = {
            print("Call Phone Number")
        }
        let viewModel = RegularDetailViewModel(icon: .phone, title: phoneNumber, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: action)
    }
    
    private static func website(using webAddress: String, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let action: () -> Void = {
            print("Open Website")
        }
        let viewModel = RegularDetailViewModel(icon: .browser, title: "Website", typography: typography, theming: theming, action: action)
        return DetailItem(type: .regular(viewModel), action: action) //Use webAdress for action
    }
    
    private static func actions(placeId: String, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let isFave = DefaultsManager.isInList(placeId: placeId, listKey: .favourites)
        let isToDo = DefaultsManager.isInList(placeId: placeId, listKey: .toDo)
 
        let shareAction: () -> Void = { print("share place") }
        let actionsItem = DetailActionsItem(isFave: isFave, isToDo: isToDo, shareAction: shareAction)

        let viewModel = DetailActionsViewModel(actions: actionsItem, placeId: placeId, theming: theming)
        return DetailItem(type: .actionButtons(viewModel), action: nil)
    }
    
    private static func reviews(reviews: [Review], typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        
        let action: (Review) -> Void = { review in print("push full eview") }
        
        let reviewsItem = ReviewSliderItem(reviews: reviews, sectionTitle: "Reviews", height: 125, action: action)
        let sliderSectionItem = SliderSectionItem(type: .reviews(reviewsItem))
        
        let viewModel = SectionSliderViewModel(sliderSectionItem: sliderSectionItem, typography: typography, theming: theming)
        return DetailItem(type: .reviews(viewModel), action: nil)
    }
    
    private static func nearby(places: [PlaceResult], typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        
        let action: (String) -> Void = { placeId in print("Push place: \(placeId)") }
        
        let placeSliderItem = PlaceSliderItem(places: places, sectionTitle: "Nearby", height: 230, action: action)
        let sliderSectionItem = SliderSectionItem(type: .nearby(placeSliderItem))
        
        let viewModel = SectionSliderViewModel(sliderSectionItem: sliderSectionItem, typography: typography, theming: theming)
        return DetailItem(type: .morePlaces(viewModel), action: nil)
    }
    
    private static func todayOpeningHours(openingHours: [String]) -> String {
        let today = Date().today()
        
        for weekDay in openingHours {
            if weekDay.hasPrefix(today) {
                return weekDay
            }
        }
        return "Opening Times"
    }
}

