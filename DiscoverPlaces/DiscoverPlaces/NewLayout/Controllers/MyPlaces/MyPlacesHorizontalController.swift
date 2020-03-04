//
//  MyListsHorizontalController.swift
//  DiscoverPlaces
//
//  Created by user on 28/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MyPlacesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
        
    var didSelectHandler: ((String) -> ())?
    var didScrollHandler: ((ListType) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FavouritesListHolderCell.self, forCellWithReuseIdentifier: FavouritesListHolderCell.id)
        collectionView.register(ToDoListHolderCell.self, forCellWithReuseIdentifier: ToDoListHolderCell.id)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == 0 {
            //Favourites
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesListHolderCell.id, for: indexPath) as! FavouritesListHolderCell
            cell.refreshData()
            cell.listController.didSelectHandler = { [weak self] placeId in
                self?.didSelectHandler?(placeId)
            }
            return cell
        } else if indexPath.row == 1 {
            //To-Do
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoListHolderCell.id, for: indexPath) as! ToDoListHolderCell
            cell.refreshData()
            return cell
        } else {
            fatalError("Should only be 2 tabs!")
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        if scrollView.contentOffset.x <= 0 {
            didScrollHandler?(.favourites)
        } else {
            didScrollHandler?(.toDo)
        }
    }
    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
