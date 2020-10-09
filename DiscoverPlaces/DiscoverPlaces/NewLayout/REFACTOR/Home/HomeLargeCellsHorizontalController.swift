
import UIKit

final class HomeLargeCellsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var didTapPlaceHandler: ((String) -> ())?
    
    var userLocation: LocationItem?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let result = results?[indexPath.item] {
            didTapPlaceHandler?(result.place_id)
        }
    }
        
    var results: [PlaceResult]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(LargePlaceCell.self, forCellWithReuseIdentifier: LargePlaceCell.id)
        collectionView.contentInset = .init(top: Constants.topPadding, left: Constants.sidePadding, bottom: Constants.bottomPadding, right: Constants.sidePadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let result = results?[indexPath.item] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargePlaceCell.id, for: indexPath) as! LargePlaceCell
        cell.actualLocation = userLocation?.actualUserLocation
        cell.result = result
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - (Constants.sidePadding + Constants.sidePadding), height: view.frame.height - (Constants.topPadding + Constants.bottomPadding + 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}