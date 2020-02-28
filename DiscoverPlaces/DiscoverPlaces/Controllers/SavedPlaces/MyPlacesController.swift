
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
    let horizontalController = MyListsHorizontalController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TemporaryFix
        let v = UIView(frame: view.frame)
        v.backgroundColor = .systemBackground
        view.addSubview(v)
        v.fillSuperview()
        
        navigationItem.largeTitleDisplayMode = .always
        v.backgroundColor = .systemBackground
        
        v.addSubview(listSelector)
        v.addSubview(horizontalController.view)

        listSelector.selectedSegmentTintColor = .systemPink
        listSelector.selectedSegmentIndex = 0
        listSelector.addTarget(self, action: #selector(toggleList(sender:)), for: .valueChanged)

        listSelector.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        horizontalController.view.anchor(top: listSelector.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        horizontalController.collectionView.reloadData()
    }
    
    @objc private func toggleList(sender: UISegmentedControl) {
 
        guard let collectionView = self.horizontalController.collectionView else { return }
        
        switch sender.selectedSegmentIndex {
        case 0:
            if collectionView.contentOffset.x > 1 {
                UIView.animate(withDuration: 0.2, animations: {
                    collectionView.contentOffset.x -= self.view.frame.width
                })
                self.view.layoutIfNeeded()
            }
        case 1:
            if collectionView.contentOffset.x < 1 {
                UIView.animate(withDuration: 0.2, animations: {
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
    
    private let favouritesHolderCellId = "favouritesHolderCellId"
    private let toDoHolderCellId = "toDoHolderCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FavouritesHolderCell.self, forCellWithReuseIdentifier: favouritesHolderCellId)
        collectionView.register(ToDoHolderCell.self, forCellWithReuseIdentifier: toDoHolderCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == 0 {
            //First tab: Favourites
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favouritesHolderCellId, for: indexPath) as! FavouritesHolderCell
            cell.refreshData()
            return cell
        } else if indexPath.row == 1 {
            //Second tab: To-Do
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toDoHolderCellId, for: indexPath) as! ToDoHolderCell
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

class FavouritesHolderCell: UICollectionViewCell {
    
    var listController = FavouritesController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(listController.view)
        listController.view.fillSuperview()
    }
    
    func refreshData() {
        listController.refreshData()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ToDoHolderCell: UICollectionViewCell {
    
    var listController = ToDoController()
    
       override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(listController.view)
        listController.view.fillSuperview()
    }
    
    func refreshData() {
        listController.refreshData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//class MyListController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    var listType: ListType!
//    var placeIdList: [String]?
//
//    let defaults = DefaultsManager()
//
//    required init(listType: ListType) {
//        self.listType = listType
//        super.init()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.backgroundColor = .systemBackground
//        refreshData()
//        collectionView.register(MyListCell.self, forCellWithReuseIdentifier: MyListCell.id)
//    }
//
//    func refreshData() {
//        placeIdList = defaults.getList(listKey: listType)
//        collectionView.reloadData()
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return placeIdList?.count ?? 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCell.id, for: indexPath) as! MyListCell
//        cell.listType = listType
//        cell.placeId = placeIdList?[indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: view.frame.width - 16 - 16, height: 100)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

class MyListCell: UICollectionViewCell {
    
    static public let id = "myListCell"
        
    var listType: ListType! {
        didSet {
           displayLabel()
        }
    }
    
    var placeId: String? {
        didSet {
            //Load Data
        }
    }
    
    func displayLabel() {
        if listType == ListType.favourites {
            placeNameLabel.text = "Favourites"
        } else if listType == ListType.toDo {
            placeNameLabel.text = "To-Do"
        }
    }
    
    func displayIcon() {
        if listType == ListType.favourites {
            setIconForState(type: .favourites)
        } else if listType == ListType.toDo {
            
        }
    }
    
    func setIconForState(type: ListType) {
        
    }

    let placeImageView = UIImageView(image: UIImage(named: "pool"))
    let placeNameLabel = UILabel(text: "Burj Khalifah", font: .systemFont(ofSize: 18, weight: .semibold), color: .label, numberOfLines: 1)
    let addressLabel = UILabel(text: "123 Palace Road, London", font: .systemFont(ofSize: 15, weight: .medium), color: .label, alignment: .left, numberOfLines: 1)
    let starView = UIView() //STARSVIEW
    let iconImageView = UIImageView(image: UIImage(systemName: "heart"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        placeImageView.layer.cornerRadius = 10
        placeImageView.clipsToBounds = true
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.constrainWidth(constant: 60)
        placeImageView.constrainHeight(constant: 60)
        
        starView.backgroundColor = .systemPink
        starView.constrainHeight(constant: 18)
        starView.constrainWidth(constant: 100)
        
        iconImageView.tintColor = .systemPink
        iconImageView.constrainWidth(constant: 30)
        iconImageView.constrainHeight(constant: 30)
        
        
        // ------------------CONFIGURE STACK VIEW ------------------ //
        let labelsStackView = VerticalStackView(arrangedSubviews: [placeNameLabel, addressLabel, starView])
        labelsStackView.setCustomSpacing(6, after: addressLabel)
        labelsStackView.alignment = .leading
        
        let stackView = HorizontalStackView(arrangedSubviews: [placeImageView, labelsStackView, iconImageView], spacing: 12)
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 4, bottom: 12, right: 4))
        
        addBottomSeparator()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




class FavouritesController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var placeIdList: [String]?
    
    let defaults = DefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        refreshData()
        collectionView.register(MyListCell.self, forCellWithReuseIdentifier: MyListCell.id)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        refreshData()
//    }
    
    func refreshData() {
        placeIdList = defaults.getList(listKey: .favourites)
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeIdList?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCell.id, for: indexPath) as! MyListCell
        cell.listType = .favourites
        cell.placeId = placeIdList?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = PlaceDetailsController()
        detailsController.placeId = placeIdList?[indexPath.item]
        present(detailsController, animated: true, completion: nil)//Change to push
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 16 - 16, height: 100)
    }
    
}


class ToDoController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var placeIdList: [String]?
    
    let defaults = DefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        refreshData()
        collectionView.register(MyListCell.self, forCellWithReuseIdentifier: MyListCell.id)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        refreshData()
//    }
    
    func refreshData() {
        placeIdList = defaults.getList(listKey: .toDo)
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeIdList?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCell.id, for: indexPath) as! MyListCell
        cell.listType = .toDo
        cell.placeId = placeIdList?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = PlaceDetailsController()
        detailsController.placeId = placeIdList?[indexPath.item]
        present(detailsController, animated: true, completion: nil)//Change to push
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 16 - 16, height: 100)
    }
    
}
