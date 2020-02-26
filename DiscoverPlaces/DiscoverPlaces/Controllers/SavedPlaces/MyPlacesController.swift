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
    //MAKE IT RESPOND BEFORE YOU LET GO
    
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
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myPlaceListHolderCellId, for: indexPath) as! MyListHolderCell
            cell.type = .favourites
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myPlaceListHolderCellId, for: indexPath) as! MyListHolderCell
            cell.type = .toDo
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

class MyListHolderCell: UICollectionViewCell {
    
    var listController: MyListController!
    
    var type: ListType! {
        didSet {
            listController = MyListController(listType: type)
            addSubview(listController.view)
            listController.view.fillSuperview()
        }
    }
    
}

class MyListController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var listType: ListType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MyListCell.self, forCellWithReuseIdentifier: MyListCell.id)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCell.id, for: indexPath) as! MyListCell
        cell.listType = listType
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 16 - 16, height: 100)
    }
    
    required init(listType: ListType) {
        self.listType = listType
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//CUSTOM PLACE LIST CELL
class MyListCell: UICollectionViewCell {
    
    static public let id = "myListCell"
    
    var listType: ListType! {
        didSet {
            if listType == ListType.favourites {
                placeNameLabel.text = "Favourite"
            } else if listType == ListType.toDo {
                placeNameLabel.text = "To-Do"
            }
        }
    }

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
        
        addSubview(placeNameLabel)
        placeNameLabel.fillSuperview()
        
        addBottomSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
