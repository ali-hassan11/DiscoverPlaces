import UIKit

final class PlaceListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var didSelectPlaceInListHandler: ((String, Location) -> ())?  //Don't think location this is used

    var listType: ListType?
    
    var placeItemList: [PlaceListItem]? {
        didSet {
            if placeItemList != oldValue {
                placeItemList?.sort{$0.timestamp < $1.timestamp}
                fetchDataForPlaceIds()
            }
        }
    }
    
    var placeResults = [PlaceDetailResult]()
    
    let defaults = DefaultsManager()
    
    init(listType: ListType) {
        self.listType = listType
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        refreshData()
        collectionView.register(MyPlaceCell.self, forCellWithReuseIdentifier: MyPlaceCell.id)
        collectionView.register(GoogleLogoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: GoogleLogoCell.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }
    
    func refreshData() {
        guard let listType = listType else { return }
        placeItemList = DefaultsManager.getList(listKey: listType)

        collectionView.reloadData()
    }
    
    let dispatchGroup = DispatchGroup()
    
    func fetchDataForPlaceIds() {
        self.placeResults.removeAll()
        
        placeItemList?.forEach{ _ in dispatchGroup.enter() }
        
        placeItemList?.forEach({ (placeItem) in
            fetchData(for: placeItem.placeId)
        })
    }
    
    func fetchData(for id: String) {
        
        let fields = ["name", "vicinity", "rating", "place_id", "photos", "geometry"]
        Service.shared.fetchPlaceDetails(placeId: id, fields: fields) { (response, error) in
            
            if let error = error {
                print("Failed to fetch: \(error)")
                return
            }
            
            //success
            guard let placeResponse = response else { return }
            guard let result = placeResponse.result else { return }
            
            self.placeResults.append(result)
            
            self.dispatchGroup.leave()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension PlaceListController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return placeResults.count
     }
     
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlaceCell.id, for: indexPath) as! MyPlaceCell
         cell.configure(place: placeResults[indexPath.item])
         return cell
     }
     
     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let place = placeResults[indexPath.item]
         let location = place.geometry.location
         didSelectPlaceInListHandler?(place.place_id, location) //Don't think location this is used
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return .init(width: view.frame.width, height: 120)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }
    
    // MARK: GoogleCell Footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GoogleLogoCell.id, for: indexPath) as! GoogleLogoCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: placeResults.count > 0 ? Constants.googleFooterHeight : .zero)
    }
}


