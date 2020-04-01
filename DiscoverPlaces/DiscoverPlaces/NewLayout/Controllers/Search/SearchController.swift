//
//  SearchController.swift
//  DiscoverPlaces
//
//  Created by user on 26/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SearchController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private let searchResponseFilter = SearchResponseFilter()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var searchResults = [PlaceResult]()
    
    private var userLocation: Location
    
    private let enterSearchTextlabel = UILabel(text: "Search for any place, anywhere!", font: .systemFont(ofSize: 17), color: .secondaryLabel, alignment: .center, numberOfLines: 0)
    
    let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass.circle.fill"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userLocation)
        searchController.searchBar.placeholder = "Restaurants in Paris..." //Array or different quiries and switch between every 3 seconds?, or just every time loads
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        addEmptyView()
        setupSearchBar()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = .init(top: 12, left: 0, bottom: 0, right: 0)
        collectionView.register(SmallSquarePlaceCell.self, forCellWithReuseIdentifier: SmallSquarePlaceCell.id)
    }
    
    override init() {
        self.userLocation = UserLocation.lastSavedLocation()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userLocation = UserLocation.lastSavedLocation()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        
        if searchText == "" {
            enterSearchTextlabel.text = "Search for places"
            return
        }
        
        let queryText = searchText.replacingOccurrences(of: " ", with: "+")
        //Take into account special characters
        
        fetchData(for: queryText)
        searchController.searchBar.placeholder = ""
    }

    private func fetchData(for queryText: String) {
        Service.shared.fetchSearchResults(for: queryText) { (response, error) in
            
            if let error = error {
                print("Failed to fetch: ", error.localizedDescription)
                return
            }
            
            //success
            guard let response = response else { return }
            
            let filteredResults = self.searchResponseFilter.results(from: response)
            self.searchResults = filteredResults
            self.updateUI(searchText: queryText)
        }
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
        searchIcon.constrainHeight(constant: 90)
        searchIcon.constrainWidth(constant: 90)
        searchIcon.tintColor = .systemPink
        
        let stackView = VerticalStackView(arrangedSubviews: [searchIcon, enterSearchTextlabel], spacing: 8)
        collectionView.addSubview(stackView)
        stackView.constrainWidth(constant: view.frame.width - 40)
        stackView.centerXInSuperview()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallSquarePlaceCell.id, for: indexPath) as! SmallSquarePlaceCell
        cell.configure(place: searchResults[indexPath.item], userLocation: userLocation)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = searchResults[indexPath.row]
        guard let placeId = result.place_id else { return }
        let placeDetailController = PlaceDetailsController(placeId: placeId, location: Location(lat: 0, lng: 0))//Get from defaults
        navigationController?.pushViewController(placeDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width - 12 - 12 - 10) / 2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
