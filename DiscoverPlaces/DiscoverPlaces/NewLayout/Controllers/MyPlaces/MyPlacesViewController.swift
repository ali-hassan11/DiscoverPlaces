
//
//  SavedPlacesController.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class MyPlacesViewController: UIViewController {
    
    let listSelector = UISegmentedControl(items: ["Favourites", "To-Do"])
    let horizontalController = MyPlacesHorizontalController()
    
    private var userLocation: Location?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsBarButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsTapped))
        navigationItem.rightBarButtonItem = settingsBarButton
        
        navigationItem.largeTitleDisplayMode = .always
        
        setupViews()
        setupSegmentedControl()
        setupContraints()
        setupDidTapPlaceHandler()
        setupDidScrollHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        horizontalController.collectionView.reloadData()
    }

    @objc private func toggleList(sender: UISegmentedControl) {
 
        guard let collectionView = self.horizontalController.collectionView else { return }
        
        switch sender.selectedSegmentIndex {
        case 0:
            if collectionView.contentOffset.x > 0 {
                UIView.animate(withDuration: 0.2, animations: {
                    collectionView.contentOffset.x -= self.view.frame.width
                })
                self.view.layoutIfNeeded()
            }
        case 1:
            if collectionView.contentOffset.x <= 0 {
                UIView.animate(withDuration: 0.2, animations: {
                    collectionView.contentOffset.x += self.view.frame.width
                })
                self.view.layoutIfNeeded()
            }
        default:
            break
        }
    }
    
    @objc func settingsTapped() {
        let settingsController = SettingsController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    
    func setupViews() {
        //TemporaryFix
        let v = UIView(frame: view.frame)
        v.backgroundColor = .systemBackground
        view.addSubview(v)
        v.fillSuperview()
        
        v.backgroundColor = .systemBackground
        
        v.addSubview(listSelector)
        v.addSubview(horizontalController.view)
    }
    
    func setupSegmentedControl() {
        listSelector.selectedSegmentTintColor = .systemPink
        listSelector.selectedSegmentIndex = 0
        listSelector.addTarget(self, action: #selector(toggleList(sender:)), for: .valueChanged)
    }
    
    private func setupContraints() {
        listSelector.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: sidePadding, bottom: 0, right: sidePadding))
        horizontalController.view.anchor(top: listSelector.bottomAnchor, leading: view.leadingAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    private func setupDidTapPlaceHandler() {
        horizontalController.didReceiveDataToPassOnHandler = { [weak self] placeId, location in
            let detailController = PlaceDetailsController(placeId: placeId, location: location) //Get from defaults
            self?.navigationController?.pushViewController(detailController, animated: true)
        }
        
    }
    
    private func setupDidScrollHandler() {
        horizontalController.didScrollMyPlacesController = { [weak self] nearestPage in
            self?.listSelector.selectedSegmentIndex = nearestPage
        }
    }
}
