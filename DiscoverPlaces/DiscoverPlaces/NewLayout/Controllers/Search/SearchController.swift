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
    fileprivate var searchResults = [PlaceResult]()
    
    private let enterSearchTextlabel = UILabel(text: "Search for places", font: .systemFont(ofSize: 17), color: .secondaryLabel, alignment: .center, numberOfLines: 0)
    
    let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass.circle.fill"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "restaurants in Barcelona..." //Array or different quiries and switch between every 3 seconds?, or just every time loads
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        addEmptyView()
        setupSearchBar()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            enterSearchTextlabel.text = "Search for places"
            return
        }
        
        let queryText = searchText.replacingOccurrences(of: " ", with: "+")
        
        searchController.searchBar.placeholder = ""
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false, block: { (_) in
                        
            Service.shared.fetchSearchResults(for: queryText) { (results, error) in
                
                if let error = error {
                    print("Failed to fetch: ", error.localizedDescription)
                    return
                }
                
                //success
                var filteredResults = [PlaceResult]()
                
                guard let results = results else { return }
                
                results.results.forEach({ (result) in
                    if result.containsPhotos()
                        && !(result.types?.contains("locality") ?? true)
                        && !(result.types?.contains("country") ?? true)
                        && !(result.types?.contains("continent") ?? true)
                    {
                        filteredResults.append(result)
                    }
                })
                
                self.searchResults = filteredResults
                self.updateUI(searchText: searchText)
            }
        })
    }
    
    private func updateUI(searchText: String) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
            if self.searchResults.isEmpty {
                
                if !searchText.isEmpty {
                    self.enterSearchTextlabel.text = "Sorry, we couldn't find anything for \"\(searchText)\""
                }
                
            } else {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }

    private func addEmptyView() {
        searchIcon.constrainHeight(constant: 120)
        searchIcon.constrainWidth(constant: 120)
        searchIcon.tintColor = .systemPink
        
        let stackView = VerticalStackView(arrangedSubviews: [searchIcon, enterSearchTextlabel], spacing: 8)
        collectionView.addSubview(stackView)
        stackView.constrainWidth(constant: view.frame.width - 40)
        stackView.alignment = .center
        stackView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100).isActive = true
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension SearchController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTextlabel.isHidden = searchResults.count != 0
        searchIcon.isHidden = searchResults.count != 0
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.searchResult = searchResults[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = searchResults[indexPath.row]
        let placeDetailController = PlaceDetailsController()
        placeDetailController.placeId = result.place_id
        placeDetailController.title = result.name
        navigationController?.pushViewController(placeDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width - 12 - 12 - 10) / 2, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
}
