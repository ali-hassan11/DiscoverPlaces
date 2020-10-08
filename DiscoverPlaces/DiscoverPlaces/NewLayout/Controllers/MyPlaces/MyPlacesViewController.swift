
//
//  SavedPlacesController.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class MyPlacesViewController: UIViewController {
    
    private var location: LocationItem?

    let listSelector = UISegmentedControl(items: ["Favourites", "To-Do"])
    let listControllersContainer = UIView()
    
    let favouritesController = PlaceListController(listType: .favourites)
    let toDoController = PlaceListController(listType: .toDo)
    
    var didTapComletionHandler: ((String, Location) -> ())?
    
    private let coordinator: NEWPlacesTabCoordinatable
    
    init(coordinator: NEWPlacesTabCoordinatable) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsBarButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsTapped))
        navigationItem.rightBarButtonItem = settingsBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.largeTitleDisplayMode = .always

        setupViews()
        setupSegmentedControl()
        setupListControllers()
        setupContraints()
        setupDidTapPlaceHandler()
    }
    
        
        guard Reachability.isConnectedToNetwork() else {
            pushNoResultsController()
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        location = UserLoation.lastSavedLocation()
    }
    
    @objc func settingsTapped() {
        coordinator.pushSettings()
    }
    
    private func setupViews() {
        //TemporaryFix
        let v = UIView(frame: view.frame)
        v.backgroundColor = .systemBackground
        view.addSubview(v)
        v.fillSuperview()
        
        v.addSubview(listSelector)
        v.addSubview(listControllersContainer)
    }
    
    private func setupListControllers() {
        // TODO: - ADD AS CHILD VIEW CONTROLLER
        addChildVC(favouritesController, on: listControllersContainer, completion: nil)
    }
    
    private func setupSegmentedControl() {
        listSelector.selectedSegmentTintColor = .systemPink
        listSelector.selectedSegmentIndex = 0
        listSelector.addTarget(self, action: #selector(toggleList(sender:)), for: .valueChanged)
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        listSelector.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    @objc private func toggleList(sender: UISegmentedControl) {
        sender.selectedSegmentIndex == 0 ? switchToFavourites() : switchToToDo()
    }
    
    private var isOnFavourites = true
    private func switchToFavourites() {
        if isOnFavourites { return }
        addChildVC(favouritesController, on: listControllersContainer, completion: { [weak self] in
            self?.toDoController.removeFromParentVC()
        })
        isOnFavourites = true
        listSelector.selectedSegmentIndex = 0
    }
    
    private func switchToToDo() {
        if !isOnFavourites { return }
        addChildVC(toDoController, on: listControllersContainer, completion: { [weak self] in
            self?.favouritesController.removeFromParentVC()
        })
       isOnFavourites = false
       listSelector.selectedSegmentIndex = 1
    }
    
    private func setupContraints() {
        listSelector.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: Constants.sidePadding, bottom: 0, right: Constants.sidePadding))
        listControllersContainer.anchor(top: listSelector.bottomAnchor, leading: view.leadingAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
        
    private func setupDidTapPlaceHandler() {
        didTapComletionHandler = { [weak self] placeId, location in  //Don't think location this is used
            guard let location = self?.location else { return }
            self?.coordinator.pushDetailController(id: placeId, userLocation: location)
        }
        
        favouritesController.didSelectPlaceInListHandler = didTapComletionHandler
        toDoController.didSelectPlaceInListHandler = didTapComletionHandler
    }
}


@nonobjc extension UIViewController {
    
    func addChildVC(_ child: UIViewController, on view: UIView, completion: (()->())?) {
        addChild(child)
        
        child.view.alpha = 0
        
        view.addSubview(child.view)
        child.view.fillSuperview()
        child.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.1) {
            child.view.alpha = 1
        }
    }
    
    func removeFromParentVC() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
