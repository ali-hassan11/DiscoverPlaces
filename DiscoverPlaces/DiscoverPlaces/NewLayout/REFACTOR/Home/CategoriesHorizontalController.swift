
import UIKit

final class CategoriesHorizontalController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    ///Used for calculation in sizeForItemAt
    private let numberOfRows:CGFloat = 3
    private let numberOfColumns:CGFloat = 2
    private let lineSpacing: CGFloat = 10
        
    var didSelectCategory: ((Category) -> ())?
    
    let categories: [Category] = [.Food, .Cafe, .Nature, .Shopping, .Attractions, .Active, .Religion, .Beauty, .Health, .Hotel, .Transport, .Family]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)
        collectionView.contentInset = .init(top: Constants.topPadding, left: Constants.sidePadding, bottom: Constants.bottomPadding, right: Constants.sidePadding)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

extension CategoriesHorizontalController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
        let categoryName = categories[indexPath.item].rawValue
        cell.categoryLabel.text = categoryName
        cell.categoryImageView.image = UIImage(named: categoryName)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCategory?(categories[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: ((view.frame.width - (Constants.leftPadding + Constants.rightPadding + lineSpacing*numberOfColumns)) / numberOfColumns), height: (view.frame.height - (lineSpacing * (numberOfRows - 1))) / numberOfRows)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
}
