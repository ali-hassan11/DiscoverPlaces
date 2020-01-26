//
//  SearchController.swift
//  DiscoverPlaces
//
//  Created by user on 26/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SearchController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let cellId = "cellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension SearchController {
    
    //Delegate & DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        return cell
    }
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 12 - 12, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
}

extension SearchController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

class SearchCell: UICollectionViewCell {
    
    let placeImageView: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.layer.backgroundColor = UIColor.clear.cgColor
        iv.layer.cornerRadius = 16 //Standardize
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor(white: 0.9, alpha: 0.7).cgColor //Standardize
        iv.layer.borderWidth = 0.5 //Standardize?
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3) //Standardize?
        iv.addSubview(overlay)
        overlay.fillSuperview()
        return iv
    }()
    
    let placeNameLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Burj Al-Arab"
        lbl.font = .boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeImageView.image = #imageLiteral(resourceName: "burj")
        
        addSubview(placeImageView)
        placeImageView.addSubview(placeNameLabel)
        placeImageView.fillSuperview()
        placeNameLabel.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}
