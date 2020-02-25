//
//  WebsiteViewController.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController {
    
    var urlString: String? {
        didSet {
            guard let url = URL(string: urlString ?? "") else {
                //URL Not valid
                return
            }
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    let webView = WKWebView()
    
    override func loadView() {
        self.view = webView
    }
    
}
