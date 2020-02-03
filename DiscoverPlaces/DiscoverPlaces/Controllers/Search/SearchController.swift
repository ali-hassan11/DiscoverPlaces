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
    fileprivate var searchResults = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addSubview(enterSearchTextlabel)
        enterSearchTextlabel.centerXInSuperview()
        enterSearchTextlabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100).isActive = true
    
        setupSearchBar()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        if searchText == "" { return }
        
        let queryText = searchText.replacingOccurrences(of: " ", with: "+")
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
                        
            Service.shared.fetchSearchResults(for: queryText) { (results, error) in
                
                if let error = error {
                    print("Failed to fetch: ", error.localizedDescription)
                    return //Error message
                }
                
                var filteredResults = [Result]()
                
                results?.results.forEach({ (result) in
                    if result.containsPhotos() {
                        filteredResults.append(result)
                    }
                })
                self.searchResults = filteredResults
                
                if self.searchResults.isEmpty {
                    print("NO RESULTS")
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    fileprivate let enterSearchTextlabel: UILabel = {
        let label = UILabel()
        label.text = "Enter search term above..."
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    
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
        enterSearchTextlabel.isHidden = searchResults.count != 0
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.searchResult = searchResults[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = searchResults[indexPath.row]
        let placeDetailController = PlaceDetailController()
        placeDetailController.result = result
        navigationController?.pushViewController(placeDetailController, animated: true)
    }
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 12 - 12, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
}