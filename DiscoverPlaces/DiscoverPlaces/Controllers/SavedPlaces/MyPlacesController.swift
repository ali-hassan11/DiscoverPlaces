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
    
    let horizontalController = MyListsHorizontalController()
    
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
 
        guard let collectionView = self.horizontalController.collectionView else { return }
        
        switch sender.selectedSegmentIndex {
        case 0:
            if collectionView.contentOffset.x > 1 {
                UIView.animate(withDuration: 0.25, animations: {
                    collectionView.contentOffset.x -= self.view.frame.width
                })
                self.view.layoutIfNeeded()
            }
        case 1:
            if collectionView.contentOffset.x < 1 {
                UIView.animate(withDuration: 0.25, animations: {
                    collectionView.contentOffset.x += self.view.frame.width
                })
                self.view.layoutIfNeeded()
            }
        default:
            break
        }
        horizontalController.collectionView.reloadData()
    }
    
}

class MyListsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    private let myPlaceListHolderCellId = "myPlaceListHolderCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(MyListHolderCell.self, forCellWithReuseIdentifier: myPlaceListHolderCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myPlaceListHolderCellId, for: indexPath) as! MyListHolderCell
        cell.type = .favourites
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

class MyListHolderCell: UICollectionViewCell {
    
    let listController = MyListController()//Inject type here
    
    var type: ListType!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(listController.view)
        listController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MyListController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //Need to know which list
    var type: ListType!
    
    private let myListCell = "myListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MyListCell.self, forCellWithReuseIdentifier: myListCell)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myListCell, for: indexPath) as! MyListCell
        cell.type = type
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 16 - 16, height: 100)
    }
    
}

//CUSTOM PLACE LIST CELL
class MyListCell: UICollectionViewCell {
    
    var type: ListType!

    let placeImageView = UIImageView(conrnerRadius: 10)
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 26, weight: .semibold), color: .label, numberOfLines: 1)
    let addressLabel = UILabel(text: "123 Palace Road, London", font: .systemFont(ofSize: 16, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)
    let starView = StarsView()
    
    //If type == fave, icon = fave, else icon = toDo

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        backgroundColor = .systemBackground
        
        
        
        addBottomSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
