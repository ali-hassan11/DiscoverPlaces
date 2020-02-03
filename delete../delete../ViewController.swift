//
//  ViewController.swift
//  delete..
//
//  Created by user on 31/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = nil
        print(label.text)
    }


}

