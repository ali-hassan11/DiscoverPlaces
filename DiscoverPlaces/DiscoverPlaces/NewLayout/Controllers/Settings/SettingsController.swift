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

class SettingsController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        tableView.backgroundColor = .systemBackground
        tableView.register(UnitsCell.self, forCellReuseIdentifier: UnitsCell.id)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "emptyId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "emptyId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reviewId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmailId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "aboutId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "termsId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "privacyId")
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: UnitsCell.id, for: indexPath) as! UnitsCell
            configure(cell: cell)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyId", for: indexPath)
            configure(cell: cell, isEmptyCell: true)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewId", for: indexPath)
            configure(cell: cell, withText: "Review")
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailId", for: indexPath)
            configure(cell: cell, withText: "Feedback")
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyId", for: indexPath)
            configure(cell: cell, isEmptyCell: true)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "aboutId", for: indexPath)
            configure(cell: cell, withText: "About")
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "privacyId", for: indexPath)
            configure(cell: cell, withText: "Privacy Policy")
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "termsId", for: indexPath)
            configure(cell: cell, withText: "Terms of Use")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func configure(cell: UITableViewCell, withText: String = "", isEmptyCell: Bool = false) {
        let label = UILabel(text: withText, color: .label, numberOfLines: 1)
        cell.addSubview(label)
        label.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        cell.backgroundColor = .systemBackground
        if isEmptyCell {
            cell.selectionStyle = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            //Units
            return 65
        case 1:
            //Empty
            return 15
        case 2:
            //Review
            return 65
        case 3:
            //Review
            return 65
        case 4:
            //Empty
            return 15
        case 5:
            //About
            return .zero ///Populate with my other apps later
        case 6:
            //Privacy
            return 65
        case 7:
            //Terms
            return 65
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 2:
            //Review
            showReviewController()
        case 3:
            //Email
            showEmailController()
        case 5:
            performSegue(withIdentifier: "AboutSegue", sender: nil)
        case 6:
            performSegue(withIdentifier: "PrivacySegue", sender: nil)
        case 7:
            performSegue(withIdentifier: "TermsSegue", sender: nil)
        default:
            return
        }
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

class UnitsCell: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "Units")
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
