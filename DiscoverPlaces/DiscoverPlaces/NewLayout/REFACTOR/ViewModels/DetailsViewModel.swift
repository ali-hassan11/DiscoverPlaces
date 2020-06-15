import UIKit

final class DetailsViewModel: NSObject {
    
    private var items: [DetailItem] = []
    
    typealias Typography = DefaultTypographyProvider & PlaceDetailTypographyProvider
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
                completion(error)
                return
            }
            
            //success
            guard let result = placeResponse?.result else {
                completion(error)
                return
            }
            
            self.populateDetailItems(with: result, completion: completion)
        }
    }
    
    ///Create Custom error that contains a string & action?
    private func populateDetailItems(with result: PlaceDetailResult, completion: @escaping (Error?) -> Void) {
        
        var items = [DetailItem]()
        
        //Main Images Slider
        if let photos = result.photos {
            
            let distance = result.geometry?.distanceString(from: location.actualUserLocation ?? location.selectedLocation)

            let mainImagesSliderItem = MainImageSliderItem(name: result.name, rating: result.rating, distance: distance, photos: photos)
            items.append(Self.configureMainImageSliderDetailItem(using: mainImagesSliderItem,
                                              typography: typography,
                                              theming: theming))
        }
        
        //Regular Cells
        if let vicinity = result.vicinity {
            items.append(Self.configureAddressDetailItem(using: vicinity,
                                       typography: self.typography,
                                       theming: self.theming))
        }
        
        if let openingHours = result.opening_hours?.weekdayText {
            items.append(Self.configureOpeningHoursDetailItem(using: openingHours,
                                           typography: self.typography,
                                           theming: self.theming))
        }
        
        if let phoneNumber = result.international_phone_number {
            items.append(Self.configurePhoneNumberDetailItem(using: phoneNumber,
                                          typography: self.typography,
                                          theming: self.theming))
        }
        
        if let webAdress = result.website {
            items.append(Self.configureWebsiteDetailItem(using: webAdress,
                                      typography: self.typography,
                                      theming: self.theming))
        } else if let googleUrl = result.url {
            items.append(Self.configureWebsiteDetailItem(using: googleUrl,
                                      typography: self.typography,
                                      theming: self.theming))
        }
        
        //Actions
        items.append(Self.configureActionsDetailItem(placeId: placeId,
                                  typography: typography,
                                  theming: theming))
        
        //Reviews
        if let reviews = result.reviews {
        items.append(Self.configureReviewsDetailItem(reviews: reviews,
                                  typography: typography,
                                  theming: theming))
        }
        
        if let location = result.geometry?.location {
            fetchMorePlacesData(near: location, items: items, completion: completion)
        } else {
            completion(nil)
        }
    }
    
    ///Create Custom error that contains a string & action?
    func fetchMorePlacesData(near location: Location, items: [DetailItem], completion: @escaping (Error?) -> Void) {
        
        Service.shared.fetchNearbyPlaces(location: location, radius: 3000) { [weak self] (response, error) in
            guard let self = self else {
                completion(nil) //Call completion without appending morePlaces
                return
            }
            
            if let _ = error {
                print("🚨 Failed to load more places 🚨")
                completion(nil) //Call completion without appending morePlaces
                return
            }
            
            //success
            guard let results = response?.results else {
                completion(nil) //Call completion without appending morePlaces
                return
            }
            
            let filteredResults = SearchResponseFilter().morePlacesResults(from: results)
            
            var items = items
            
            items.append(Self.configureNearbyPlacesDetailItem(places: filteredResults,
                                     typography: self.typography,
                                     theming: self.theming))
            
            items.append(DetailItem(type: .googleFooter, action: nil))
            
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
            return configureCell(cellType: RegularCell.self, at: indexPath, tableView: tableView, viewModel: regularDetailViewModel)
        case .mainImagesSlider(let mainImageSliderViewModel):
            return configureCell(cellType: MainImageSliderCell.self, at: indexPath, tableView: tableView, viewModel: mainImageSliderViewModel)
        case .actionButtons(let actionsViewModel):
           return configureCell(cellType: DetailActionsCell.self, at: indexPath, tableView: tableView, viewModel: actionsViewModel)
        case .reviews(let reviewSliderViewModel):
            return configureCell(cellType: SectionSliderCell.self, at: indexPath, tableView: tableView, viewModel: reviewSliderViewModel)
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

// MARK: Configure Cell Methods
extension DetailsViewModel {

    //Make into 1 method for all
    typealias DetailCell = UITableViewCell & NibLoadableReusable & DetailCellConfigurable
    
    private func configureCell<T: DetailCell>(cellType: T.Type, at indexPath: IndexPath, tableView: UITableView, viewModel: DetailItemViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
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
    
    private static func configureMainImageSliderDetailItem(using mainImageSliderItem: MainImageSliderItem, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        
        let viewModel = MainImageSliderViewModel(mainImageSliderItem: mainImageSliderItem, typography: typography, theming: theming)
        return DetailItem(type: .mainImagesSlider(viewModel), action: nil)
    }
    
    private static func configureAddressDetailItem(using vicinity: String, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let action: () -> Void = {
            print("Open Maps")
        }
        let viewModel = RegularDetailViewModel(icon: .mapPin, title: vicinity, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: action)
    }
    
    private static func configureOpeningHoursDetailItem(using openingHours: [String], typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let action: () -> Void = {
            print("Open Opening Hours")
        }
        let todaysOpeningHoursText = todayOpeningHours(openingHours: openingHours)
        
        let viewModel = RegularDetailViewModel(icon: .time, title: todaysOpeningHoursText, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: action)
    }
    
    private static func configurePhoneNumberDetailItem(using phoneNumber: String, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let action: () -> Void = {
            print("Call Phone Number")
        }
        let viewModel = RegularDetailViewModel(icon: .phone, title: phoneNumber, typography: typography, theming: theming)
        return DetailItem(type: .regular(viewModel), action: action)
    }
    
    private static func configureWebsiteDetailItem(using webAddress: String, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let action: () -> Void = {
            print("Open Website")
        }
        let viewModel = RegularDetailViewModel(icon: .browser, title: "Website", typography: typography, theming: theming, action: action)
        return DetailItem(type: .regular(viewModel), action: action) //Use webAdress for action
    }
    
    private static func configureActionsDetailItem(placeId: String, typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        let isFave = DefaultsManager.isInList(placeId: placeId, listKey: .favourites)
        let isToDo = DefaultsManager.isInList(placeId: placeId, listKey: .toDo)
 
        let shareAction: () -> Void = { print("share place") }
        let actionsItem = DetailActionsItem(isFave: isFave, isToDo: isToDo, shareAction: shareAction)

        let viewModel = DetailActionsViewModel(actions: actionsItem, placeId: placeId, theming: theming)
        return DetailItem(type: .actionButtons(viewModel), action: nil)
    }
    
    private static func configureReviewsDetailItem(reviews: [Review], typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        
        let action: (Review) -> Void = { review in print("push full eview") }
        
        let reviewsItem = ReviewSliderItem(reviews: reviews, sectionTitle: "Reviews", height: 125, action: action)
        let sliderSectionItem = SliderSectionItem(type: .reviews(reviewsItem))
        
        let viewModel = SectionSliderViewModel(sliderSectionItem: sliderSectionItem, typography: typography, theming: theming)
        return DetailItem(type: .reviews(viewModel), action: nil)
    }
    
    private static func configureNearbyPlacesDetailItem(places: [PlaceResult], typography: Typography, theming: PlaceDetailTheming) -> DetailItem {
        
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
