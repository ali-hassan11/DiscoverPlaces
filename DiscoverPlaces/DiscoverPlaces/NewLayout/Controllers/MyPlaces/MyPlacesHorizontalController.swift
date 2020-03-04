//
//  MyListsHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 28/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MyPlacesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    private let favouritesHolderCellId = "favouritesHolderCellId"
    private let toDoHolderCellId = "toDoHolderCellId"
    
    var didSelectHandler: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FavouritesListHolderCell.self, forCellWithReuseIdentifier: favouritesHolderCellId)
        collectionView.register(ToDoListHolderCell.self, forCellWithReuseIdentifier: toDoHolderCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == 0 {
            //Favourites
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favouritesHolderCellId, for: indexPath) as! FavouritesListHolderCell
            cell.refreshData()
            cell.listController.didSelectHandler = { [weak self] placeId in
                self?.didSelectHandler?(placeId)
            }
            return cell
        } else if indexPath.row == 1 {
            //To-Do
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toDoHolderCellId, for: indexPath) as! ToDoListHolderCell
            cell.refreshData()
            return cell
        } else {
            fatalError("Should only be 2 tabs!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
