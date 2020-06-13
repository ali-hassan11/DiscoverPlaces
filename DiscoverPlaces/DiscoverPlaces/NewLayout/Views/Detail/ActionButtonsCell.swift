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

final class ActionButtonsCell: UICollectionViewCell {
    
    public static let id = "actionButtonsCellId"

    var delegate: ActionButtonsCellDelegate?

    //Move this to an icon enum
    let heartOutline = UIImage(systemName: "heart")
    let heartFilled = UIImage(systemName: "heart.fill")
    
    let toDoOutline = UIImage(systemName: "bookmark")
    let toDoFilled = UIImage(systemName: "bookmark.fill")
            
    var placeId: String! {
        didSet {
            let isFavourite = DefaultsManager.isInList(placeId: placeId, listKey: .favourites)
            favouritesButton.setImage(isFavourite ? heartFilled : heartOutline, for: .normal)
            
            let isToDo = DefaultsManager.isInList(placeId: placeId, listKey: .toDo)
            toDoButton.setImage(isToDo ? toDoFilled : toDoOutline, for: .normal)
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
        btn.roundCorners()
        return btn
    }()

    let toDoButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.setTitle(" To-Do", for: .normal)
        btn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.systemPink
        btn.roundCorners()
        return btn
    }()

    let shareButton: UIButton! = {
        let btn = UIButton(type: .system)
        btn.setTitle(" Share", for: .normal)
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.systemPink
        btn.roundCorners()
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
        toggleFavourites(placeId: placeId)
    }
    
    @objc private func toDoTapped() {
        toggleToDo(placeId: placeId)
    }
        
    func toggleFavourites(placeId: String) {
        let isFavourite = DefaultsManager.isInList(placeId: placeId, listKey: .favourites)
        
        isFavourite ? DefaultsManager.removeFromList(placeId: placeId, listKey: .favourites) : DefaultsManager.addToList(placeId: placeId, listKey: .favourites)
        favouritesButton.setImage(isFavourite ? heartOutline : heartFilled, for: .normal)
    }
    
    func toggleToDo(placeId: String) {
        let isToDo = DefaultsManager.isInList(placeId: placeId, listKey: .toDo)
              
        isToDo ? DefaultsManager.removeFromList(placeId: placeId, listKey: .toDo) : DefaultsManager.addToList(placeId: placeId, listKey: .toDo)
        toDoButton.setImage(isToDo ? toDoOutline : toDoFilled, for: .normal)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
