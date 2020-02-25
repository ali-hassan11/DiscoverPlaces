//
//  ActionButtonsCell.swift
//  DiscoverPlaces
//
//  Created by Ali Hassan on 14/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ActionButtonsCell: UICollectionViewCell {
    
    //Move this to an icon enum
    let heartOutline = UIImage(systemName: "heart")
    let heartFilled = UIImage(systemName: "heart.fill")
    
    let defaults = FavouriteDefaultsManager()
    
    var placeId: String! {
        didSet {
            isFavourite = defaults.isFavourite(placeId: placeId)
        }
    }
    
    var isFavourite: Bool! {
        didSet {
            toggleFavourites(placeId: placeId)
            print(defaults.getFavourites())
        }
    }
    
    var isToDo: Bool! {
        didSet {
            let addToDoImage = UIImage(systemName: "text.badge.plus"), removeToDoImage = UIImage(systemName: "text.badge.minus")
            toDoButton.setImage(isToDo ? removeToDoImage : addToDoImage, for: .normal)
            
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
        favouritesButton.addTarget(self, action: #selector(favouritePressed), for: .touchUpInside)
        toDoButton.addTarget(self, action: #selector(toDoPressed), for: .touchUpInside)
    }

    @objc private func favouritePressed() {
        isFavourite = isFavourite ? false : true
    }
        
    func toggleFavourites(placeId: String) {
        let isFave = defaults.isFavourite(placeId: placeId)
        
        isFave ? defaults.removeFromFavourites(placeId: placeId) : defaults.addToFavourites(placeId: placeId)
        favouritesButton.setImage(isFave ? heartOutline : heartFilled, for: .normal)
    }
    
    @objc private func toDoPressed() {
        //Check if id is in list of faves
        toggleToDoButton()
    }

    private func toggleToDoButton() {
        isToDo = isToDo ? false : true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class FavouriteDefaultsManager {
    
    private let favouritesKey = "faveKey"
    func addToFavourites(placeId: String) {
        //CAN MAKE THIS ALOT SIMPLE: LOOK AT ADD TO CATEGORIES
        if var favourites = UserDefaults.standard.object(forKey: favouritesKey) as? [String] {
            if !favourites.contains(placeId) {
                favourites.append(placeId)
                UserDefaults.standard.set(favourites, forKey: favouritesKey)
//                print("Added to faves, new Faves: \(favourites)")
            } else {
//                print("Already in Faves")
            }
        } else {
            let newFavourites = [placeId]
            UserDefaults.standard.set(newFavourites, forKey: favouritesKey)
//            print("First Fave added, new Faves: \(newFavourites)")
        }
    }
    
    func removeFromFavourites(placeId: String) {
        //CAN MAKE THIS ALOT SIMPLE: LOOK AT ADD TO CATEGORIES
        if var favourites = UserDefaults.standard.object(forKey: favouritesKey) as? [String] {
            if favourites.contains(placeId) {
                favourites = favourites.filter{$0 != placeId}
                UserDefaults.standard.set(favourites, forKey: favouritesKey)
//                print("\(placeId) removed, new Faves: \(favourites)")
            } else {
//                print("Tried to remove \(placeId), but wasnt found in Faves.")
            }
        } else {
//            print("No faves yet")
        }
    }
    
    func getFavourites() -> [String] {
        if let favourites = UserDefaults.standard.object(forKey: favouritesKey) as? [String] {
//            print("getFaves: \(favourites)")
            return favourites
        } else {
//            print("No Faves yet!")
            return []
        }
    }
    
    func isFavourite(placeId: String) -> Bool {
        if let favourites = UserDefaults.standard.object(forKey: favouritesKey) as? [String] {
            if favourites.contains(placeId) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}
