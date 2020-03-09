//
//  SettingsController.swift
//  DiscoverPlaces
//
//  Created by user on 08/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class SettingsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
            
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UnitsCell.self, forCellWithReuseIdentifier: UnitsCell.id    )
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitsCell.id, for: indexPath) as! UnitsCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 65)
    }
    
}

class UnitsCell: UICollectionViewCell {

    public static let id = "unitsCellId"
    
    let unitsSwitch: UISegmentedControl! = {
        let sc = UISegmentedControl(items: ["Km", "Miles"])
        sc.constrainWidth(constant: 150)
        sc.constrainHeight(constant: 35)
        sc.selectedSegmentTintColor = .systemPink
        sc.selectedSegmentIndex = DefaultsManager.isKm() ? 0 : 1
        return sc
    }()
    
    let label = UILabel(text: "Units", color: .label, alignment: .left, numberOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        unitsSwitch.addTarget(self, action: #selector(toggleUnits(sender:)), for: .valueChanged)
        
        addSubview(unitsSwitch)
        unitsSwitch.centerYInSuperview()
        unitsSwitch.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        
        addSubview(label)
        label.centerYInSuperview()
        label.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: unitsSwitch.leadingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 12))
        
        addBottomSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleUnits(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            DefaultsManager.setUnits(to: .km)
            print("Set to Km")
        case 1:
            DefaultsManager.setUnits(to: .miles)
            print("Set to Miles")
        default:
            break
        }
    }
    
}
