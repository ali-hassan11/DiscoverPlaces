//
//  AboutController.swift
//  DiscoverPlaces
//
//  Created by user on 05/04/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class AboutController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "About"
        
        let label = UILabel()
        label.numberOfLines = 0
        #warning("Write about text")
        label.text = "When working in projects that has too many xib or views used in viewcontroller,It is quite difficult to track which controller has been used to embed views or Xib.For that you need to use delegate to find which view controller is used by xibs. I have an extension for UIViewController which you can present alert directly in the rootViewController of the project.It saves lot time to figure which viewController to show the alert."
        
        let getInTouchButton = UIButton(title: "Get In Touch", textColor: .label, font: .systemFont(ofSize: 17), backgroundColor: .secondarySystemBackground)
        getInTouchButton.constrainHeight(constant: 50)
        getInTouchButton.roundCorners()
        
        let stackView = VerticalStackView(arrangedSubviews: [label, getInTouchButton, UIView()], spacing: 12)
        view.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
}
