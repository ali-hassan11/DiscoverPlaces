//
//  WebsiteViewController.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

final class WebsiteViewController: UIViewController {
    
    var webAddress: String? {
        didSet {
            guard let url = URL(string: webAddress ?? "") else {
                //TODO: URL Not valid, show error
                return
            }
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    let safariIcon = UIImage(systemName: "safari")
    let webView = WKWebView()
    
    init(webAddress: String) {
        self.webAddress = webAddress
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let openInSafariBarButton = UIBarButtonItem(image: safariIcon, style: .plain, target: self, action: #selector(openInSafari))
        navigationItem.rightBarButtonItem = openInSafariBarButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkNetworkConnection()
    }
    
    func checkNetworkConnection () {
        guard Reachability.isConnectedToNetwork() else {
            self.showNoConnectionAlert(popSelf: true)
            return
        }
    }
        
    @objc private func openInSafari() {
        guard let url = URL(string: webAddress ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
