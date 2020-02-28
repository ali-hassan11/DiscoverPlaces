//
//  ActionButtonsCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

protocol ActionButtonsCellDelegate: class {
    func sharePressed(cell: ActionButtonsCell)
}

class ActionButtonsCell: UICollectionViewCell {
    
    public static let id = "actionButtonsCellId"

    //Move this to an icon enum
    let heartOutline = UIImage(systemName: "heart")
    let heartFilled = UIImage(systemName: "heart.fill")
    
    let addToDoImage = UIImage(systemName: "text.badge.plus")
    let removeToDoImage = UIImage(systemName: "text.badge.minus")
    
    let defaults = DefaultsManager()
    
    var delegate: ActionButtonsCellDelegate?
    
    var placeId: String! {
        didSet {
            isFavourite = defaults.isInList(placeId: placeId, listKey: .favourites)
            isToDo = defaults.isInList(placeId: placeId, listKey: .toDo)
        }
    }
    
    var isFavourite: Bool? {
        didSet {
            toggleFavourites(placeId: placeId)
            print(defaults.getList(listKey: .favourites))
        }
    }
    
    var isToDo: Bool? {
        didSet {
            toggleToDo(placeId: placeId)
            print(defaults.getList(listKey: .toDo))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        addbuttonActions()
    }
    
    let favouritesButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.setTitle(" Favourite", for: .normal)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.systemPink
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()

    let toDoButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.setTitle(" To-Do", for: .normal)
        btn.setImage(UIImage(systemName: "text.badge.plus"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.systemPink
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()

    let shareButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.setTitle(" Share", for: .normal)
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.systemPink
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()

    private func setupViews() {
        let stackView = HorizontalStackView(arrangedSubviews: [favouritesButton, toDoButton, shareButton], spacing: 8)
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 20, bottom: 10, right: 20))

        addBottomSeparator()
    }
    
    private func addbuttonActions() {
        favouritesButton.addTarget(self, action: #selector(favouriteTapped), for: .touchUpInside)
        toDoButton.addTarget(self, action: #selector(toDoTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }
    
    @objc func shareTapped(sender: UIButton) {
        delegate?.sharePressed(cell: self)
    }

    @objc private func favouriteTapped() {
        isFavourite = isFavourite ?? false ? false : true
    }
    
    @objc private func toDoTapped() {
        isToDo = isToDo ?? false ? false : true
    }
        
    func toggleFavourites(placeId: String) {
        let isFave = defaults.isInList(placeId: placeId, listKey: .favourites)
        
        isFave ? defaults.removeFromList(placeId: placeId, listKey: .favourites) : defaults.addToList(placeId: placeId, listKey: .favourites)
        favouritesButton.setImage(isFave ? heartOutline : heartFilled, for: .normal)
    }
    
    func toggleToDo(placeId: String) {
        let isToDo = defaults.isInList(placeId: placeId, listKey: .toDo)
              
        isToDo ? defaults.removeFromList(placeId: placeId, listKey: .toDo) : defaults.addToList(placeId: placeId, listKey: .toDo)
        toDoButton.setImage(isToDo ? addToDoImage : removeToDoImage, for: .normal)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
