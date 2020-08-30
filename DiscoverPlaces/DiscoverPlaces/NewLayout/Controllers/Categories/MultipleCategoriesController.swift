
import UIKit

final class MultipleCategoriesController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let activityIndicatorView = LoadingIndicatorView()
    
    private let searchResponseFilter = SearchResponseFilter()
    private let dispatchGroup = DispatchGroup()
    
    private var location: LocationItem
    private var category: Category
    
    private let coordinator: CategoriesCoordinatable

    struct SubCategoryGroup {
        let name: String
        let results: [PlaceResult]
    }

    private var subCategoryGroups = [SubCategoryGroup]()
    
    init(coordinator: CategoriesCoordinatable, category: Category, location: LocationItem) {
        self.location = location
        self.category = category
        self.coordinator = coordinator
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.rawValue
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupCollectionView()
        
        fetchDataAfterDelay()
    }
    private func fetchDataAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Loading Indicator (IN CENTER!)
            self.view.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.centerInSuperview()
            
            self.fetchSubCategoryGroups(category: self.category, selectedLocation: self.location.selectedLocation)
        }
    }
    
    private func fetchSubCategoryGroups(category: Category, selectedLocation: Location?) {
        
        guard Reachability.isConnectedToNetwork() else {
            self.showErrorController(error: .init(title: Constants.noInternetConnectionTitle,
                                                  message: Constants.noInternetConnetionMessage))
            return
        }
        
        category.subCategories().forEach { _ in
            dispatchGroup.enter()
        }
        
        self.subCategoryGroups.removeAll()
        category.subCategories().forEach {
            fetchdata(subCategory: $0, selectedLocation: location.selectedLocation)
        }
        
        fetchCompletion()
    }
    
    private func fetchdata(subCategory: SubCategory, selectedLocation: Location) {
        
        Service.shared.fetchNearbyPlaces(selectedLocation: selectedLocation, subCategory: subCategory) { (response, error) in
            
            if let error = error {
                print("Failed to fetch: \(error)")
                self.dispatchGroup.leave()
                return
            }
            
            //success
            guard let response = response else {
                self.dispatchGroup.leave()
                return
            }
            
            let results = self.searchResponseFilter.results(from: response)
            
            guard results.count > 0 else {
                self.dispatchGroup.leave()
                return
            }
            
            let subCategoryGroup = SubCategoryGroup(name: subCategory.name(), results: results)
            self.subCategoryGroups.append(subCategoryGroup)
            self.subCategoryGroups.sort{$0.results.count > $1.results.count}
            self.dispatchGroup.leave()
        }
        
    }
    
//    private func pushNoConnectionController() {
//        let errorController = ErrorController(message: Constants.genericNoConnectionMessage, buttonTitle: Constants.backtext) {
//            ///DidTapRetryButtonHandler
//            self.navigationController?.popToRootViewController(animated: true)
//        }
//        self.navigationController?.pushViewController(errorController, animated: true)
//    }
//    
    private func showErrorController(error: CustomError) {
        coordinator.pushErrorController(message: error.message)
    }
    
    private func fetchCompletion() {
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
            self.activityIndicatorView.stopAnimating()
            
            guard self.subCategoryGroups.isEmpty == false else {
                self.coordinator.pushErrorController(message: Constants.noResultsMessage)
                return
            }
            
            UIView.animate(withDuration: 0.35) {
                self.collectionView.alpha = 1
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.alpha = 0
        collectionView.reloadData()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SubCategoryiesHolder.self, forCellWithReuseIdentifier: SubCategoryiesHolder.id)
        collectionView.register(GoogleLogoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: GoogleLogoCell.id)
    }
    
    private func pushNoResultsController() {
        let errorController = ErrorController(message: Constants.noResults(category.rawValue), buttonTitle: Constants.backtext) {
            ///DidTapActionButtonHandler
            self.navigationController?.popToRootViewController(animated: true)
        }
        self.navigationController?.pushViewController(errorController, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MultipleCategoriesController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategoryGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryiesHolder.id, for: indexPath) as! SubCategoryiesHolder
        
        let subCategoryGroup = subCategoryGroups[indexPath.item]
        cell.subCategoryTitleLabel.text = subCategoryGroup.name
        cell.horizontalController.results = subCategoryGroup.results
        cell.horizontalController.location = self.location.selectedLocation
        cell.horizontalController.didSelectPlaceHandler = { [weak self] placeId in
            guard let location = self?.location else { return }
            self?.coordinator.pushDetailController(id: placeId, userLocation: location)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: GoogleCell Footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GoogleLogoCell.id, for: indexPath) as! GoogleLogoCell
        cell.addTopSeparator()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: Constants.googleFooterHeight)
    }
}
