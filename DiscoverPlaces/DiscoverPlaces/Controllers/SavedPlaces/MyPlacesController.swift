//
//  SavedPlacesController.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MyPlacesController: UIViewController {
    
    let listSelector = UISegmentedControl(items: ["Favourites", "To-Do"])
    
//    let favourtiesController = SavedPlacesTableViewController(listType: .favourites)
//    let toDoController = SavedPlacesTableViewController(listType: .toDo)
    
    let horizontalController = SavedListsHorizontalController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TemporaryFix
        let v = UIView(frame: view.frame)
        v.backgroundColor = .systemBackground
        view.addSubview(v)
        v.fillSuperview()
        
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .green
        
        v.addSubview(listSelector)
        v.addSubview(horizontalController.view)

        listSelector.selectedSegmentTintColor = .systemPink
        listSelector.selectedSegmentIndex = 0
        listSelector.addTarget(self, action: #selector(toggleList(sender:)), for: .valueChanged)

        listSelector.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        horizontalController.view.anchor(top: listSelector.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    @objc private func toggleList(sender: UISegmentedControl) {
 
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.25, animations: {
                self.horizontalController.collectionView.contentOffset.x -= self.view.frame.width
            })
            self.view.layoutIfNeeded()

        case 1:
            UIView.animate(withDuration: 0.25, animations: {
                self.horizontalController.collectionView.contentOffset.x += self.view.frame.width
            })
            self.view.layoutIfNeeded()

        default:
            break
        }
        horizontalController.collectionView.reloadData()
    }
    
}

class SavedListsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    private let myPlaceListHolderCellId = "myPlaceListHolderCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(MyPlaceListHolderCell.self, forCellWithReuseIdentifier: myPlaceListHolderCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myPlaceListHolderCellId, for: indexPath) as! MyPlaceListHolderCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

class MyPlaceListHolderCell: UICollectionViewCell {
    
    let tableView = MyPlaceListController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView.view)
        tableView.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MyPlaceListController: UITableViewController {
    
    private let savedPlaceCellId = "savedPlaceCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: savedPlaceCellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: savedPlaceCellId, for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
    
}
