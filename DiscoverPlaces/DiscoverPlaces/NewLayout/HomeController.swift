//
//  HomeController.swift
//  DiscoverPlaces
//
//  Created by user on 05/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

let topPadding: CGFloat = 0
let bottomPadding: CGFloat = 0
let leftPadding: CGFloat = 20
let rightPadding: CGFloat = 20

class HomeController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let largeCellHolderId = "largeCellHeaderId"
    fileprivate let categoriesHolderId = "categoriesHolderId"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoriesHolder.self, forCellWithReuseIdentifier: categoriesHolderId)
        //Header 1
        collectionView.register(HomeLargeCellHolder.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: largeCellHolderId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesHolderId, for: indexPath) as! CategoriesHolder
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 380)
    }
    
    //Header 2
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: largeCellHolderId, for: indexPath) as! HomeLargeCellHolder
        return cell
    }
    
    //Header 3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 480)
    }
 
}

//--------------------------HEADER--------------------------

class HomeLargeCellHolder: UICollectionReusableView {
    
    let sectionDescriptionLabel = UILabel(text: "Trending places near London", font: .systemFont(ofSize: 16, weight: .medium),color: .secondaryLabel , numberOfLines: 0)
    
    let paddingView = PaddingView(width: leftPadding)
    
    let horizontalController = HomeLargeCellsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [paddingView, sectionDescriptionLabel]),
                                                             horizontalController.view], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HomeLargeCellsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let largeCellId = "largeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HomeLargeCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView.contentInset = .init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - (leftPadding + rightPadding), height: view.frame.height - (topPadding + bottomPadding))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

let primaryHighlightColor = UIColor(displayP3Red: 255/255, green: 52/255, blue: 102/255, alpha: 1)

class HomeLargeCell: UICollectionViewCell {
    
    let placeImageView = UIImageView(image: UIImage(named: "hotel"))
    let planeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 26, weight: .semibold), color: .white, numberOfLines: 3)
    let distanceLabel = UILabel(text: "1.7 Km", font: .systemFont(ofSize: 16, weight: .semibold), color: .lightText, numberOfLines: 1)
    let undicededButton = UIButton(title: "Details", textColor: .white, width: 100, height: 40, font: .systemFont(ofSize: 18, weight: .medium), backgroundColor: primaryHighlightColor, cornerRadius: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true

        placeImageView.contentMode = .scaleAspectFill
        addSubview(placeImageView)
        placeImageView.fillSuperview()

        let stackView = HorizontalStackView(arrangedSubviews: [
            VerticalStackView(arrangedSubviews: [planeNameLabel, distanceLabel], spacing: 8),
            undicededButton
        ])
        placeImageView.addSubview(stackView)
        stackView.alignment = .bottom
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 24, bottom: 24, right: 24), size: .zero)
        
        placeImageView.addGradientBackground(firstColor: .clear, secondColor: .black)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//--------------------------MAIN--------------------------

class CategoriesHolder: UICollectionViewCell {
    
    let sectionTitleLabel = UILabel(text: "Feeling Adventurous", font: .systemFont(ofSize: 24, weight: .bold),color: .label, numberOfLines: 0)
    let sectionDescriptionLabel = UILabel(text: "Get inspiration from our range of categories, why not try something new...", font: .systemFont(ofSize: 16, weight: .medium),color: .secondaryLabel , numberOfLines: 0)
    
    let horizontalController = CategoriesHorizontalController()
 
    let paddingView = PaddingView(width: leftPadding)
    let paddingView2 = PaddingView(width: leftPadding)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        let stackiew = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [PaddingView(width: leftPadding), sectionTitleLabel]),
                                                            UIStackView(arrangedSubviews: [PaddingView(width: leftPadding), sectionDescriptionLabel, PaddingView(width: leftPadding)]),
                                                            horizontalController.view], spacing: 12)
        addSubview(stackiew)
        stackiew.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CategoriesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let categoryCellId = "categoryCellId"
    fileprivate let numberOfRows:CGFloat = 3
    fileprivate let numberOfColumns:CGFloat = 2
    fileprivate let lineSpacing: CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
        collectionView.contentInset = .init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: ((view.frame.width - (leftPadding + rightPadding + lineSpacing*numberOfColumns)) / numberOfColumns), height: (view.frame.height - (lineSpacing * (numberOfRows - 1))) / numberOfRows)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
}

class CategoryCell: UICollectionViewCell {
    
    let categoryLabel = UILabel(text: "Food", font: .systemFont(ofSize: 20, weight: .semibold), color: .white, numberOfLines: 0)
    let categoryImageView = UIImageView(image: UIImage(named: "cafe"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
        
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.addOverlay(color: .black, alpha: 0.35)

        
        addSubview(categoryImageView)
        categoryImageView.fillSuperview()
        categoryImageView.addSubview(categoryLabel)
        categoryLabel.centerInSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
