//
//  ActionButtonsCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ActionButtonsCell: UICollectionViewCell {

    var isFavourite: Bool! {
        didSet {
            let heartOutline = UIImage(systemName: "heart"), heartFilled = UIImage(systemName: "heart.fill")
            favouritesButton.setImage(isFavourite ? heartFilled : heartOutline, for: .normal)
            animateButtonPress(button: favouritesButton)
            
            if isFavourite {
                //remove from user defauls
            } else {
                //add to user defaults
            }
        }
    }
    
    var isToDo: Bool! {
        didSet {
            let addToDoImage = UIImage(systemName: "text.badge.plus"), removeToDoImage = UIImage(systemName: "text.badge.minus")
            toDoButton.setImage(isToDo ? removeToDoImage : addToDoImage, for: .normal)
            animateButtonPress(button: toDoButton)
            
            if isToDo {
                //remove from user defauls
            } else {
                //add to user defaults
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        setButtonsState()
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
    
    private func setButtonsState() {
        isFavourite = false
        isToDo = false
    }
    
    private func addbuttonActions() {
        favouritesButton.addTarget(self, action: #selector(favouritePressed), for: .touchUpInside)
        toDoButton.addTarget(self, action: #selector(toDoPressed), for: .touchUpInside)
    }

    @objc private func favouritePressed() {
        //Check if id is in list of faves
        toggleFaveouritesButton()
    }
    
    @objc private func toDoPressed() {
        //Check if id is in list of faves
        toggleToDoButton()
    }
    
    private func addToFavourites() {
        
    }
    
    private func removeFromFaveourite() {
        //Update user defaults
    }
    
    private func toggleFaveouritesButton() {
        isFavourite = isFavourite ? false : true
    }
    
    private func toggleToDoButton() {
        isToDo = isToDo ? false : true
    }
    
    private func animateButtonPress(button: UIButton) {
        let originalFrame = button.frame
        UIView.animate(withDuration: 0.1, animations: {
            button.imageView?.frame = .init(x: 0, y: 0, width: 60, height: 60)
        }) { (true) in
            button.imageView?.frame = originalFrame
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
