//
//  SettingsController.swift
//  DiscoverPlaces
//
//  Created by user on 08/03/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class SettingsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {
            
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UnitsCell.self, forCellWithReuseIdentifier: UnitsCell.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reviewId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "EmailId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "aboutId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "termsId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "privacyId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitsCell.id, for: indexPath) as! UnitsCell
            configure(cell: cell)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyId", for: indexPath)
            configure(cell: cell)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewId", for: indexPath)
            configure(cell: cell, withText: "Review")
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmailId", for: indexPath)
            configure(cell: cell, withText: "Feedback", hasSeparator: false)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyId", for: indexPath)
            configure(cell: cell)
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutId", for: indexPath)
            configure(cell: cell, withText: "About")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    private func configure(cell: UICollectionViewCell, withText: String = "", hasSeparator: Bool = true) {
        let label = UILabel(text: withText, color: .label, numberOfLines: 1)
        cell.addSubview(label)
        label.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        cell.backgroundColor = .systemBackground
        cell.addBottomSeparator()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            //Review
            showReviewController()
        case 3:
            //Email
            showEmailController()
        case 5:
            //About
            showAboutController()
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            //Units
            return .init(width: view.frame.width, height: 65)
        case 1:
            //Empty
            return .init(width: view.frame.width, height: 15)
        case 2:
            //Review
            return .init(width: view.frame.width, height: 65)
        case 3:
            //Review
            return .init(width: view.frame.width, height: 65)
        case 4:
            //Empty
            return .init(width: view.frame.width, height: 15)
        case 5:
            //About
            return .init(width: view.frame.width, height: 65)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if indexPath.item == 0 || indexPath.item == 1 || indexPath.item == 3 { return }
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .quaternarySystemFill
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = nil

    }
    
    private func showReviewController() {
         SKStoreReviewController.requestReview()
     }
    
    private func showEmailController() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["ali.software.dev@gmail.com"])
            
            #warning("Put correct name here")
            mail.setSubject("Feedback on Discover Places App")

            present(mail, animated: true)
        } else {
            showToastAlert(title: "Unable to access email")
        }
    }
    
    private func showAboutController() {
        let controller = AboutController()
        navigationController?.pushViewController(controller, animated: true)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleUnits(sender: UISegmentedControl) {
        DefaultsManager.setUnits(to: sender.selectedSegmentIndex == 0 ? .km : .miles)
    }
    
}
