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
    fileprivate var placeResults = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
            self.fetchData(searchText: searchText)
        })
    }
    

    fileprivate func fetchData(searchText: String) {
        
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchText)&location=42.3675294,-71.186966&key=AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Falied to fetch:, ", err)
                return
            }
            
            //success
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                self.placeResults = response.results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let jsonErr {
                print("Failed to decoded: ", jsonErr)
                return
            }
            
            //CREATE NEW EMAIL FOR THIS APP, SET UP PLACES API, SET UP DEV KEY
            
        }.resume()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

struct Response: Decodable {
    let results: [Result]
    let next_page_token: String?
}

struct Result: Decodable {
    let name: String
}

extension SearchController {
    
    //Delegate & DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        let placeResult = self.placeResults[indexPath.item]
        cell.placeNameLabel.text = placeResult.name
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
