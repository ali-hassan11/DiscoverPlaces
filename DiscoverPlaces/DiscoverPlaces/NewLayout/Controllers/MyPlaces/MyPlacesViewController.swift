
//
//  SavedPlacesController.swift
//  DiscoverPlaces
//
//  Created by user on 25/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class MyPlacesViewController: UIViewController {
    
    let listSelector = UISegmentedControl(items: ["Favourites", "To-Do"])
    let listControllersContainer = UIView()
    
    let favouritesController = PlaceListController(listType: .favourites)
    let toDoController = PlaceListController(listType: .toDo)
    
    private var location: LocationItem?
    
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
        let settingsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SettingsVCId") as UITableViewController
        navigationController?.pushViewController(settingsController, animated: true)
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
        
        switch sender.selectedSegmentIndex {
        case 0:
            addChildVC(favouritesController, on: listControllersContainer, completion: { [weak self] in
                self?.toDoController.remove()
            })
        case 1:
            addChildVC(toDoController, on: listControllersContainer, completion: { [weak self] in
                self?.favouritesController.remove()
            })
        default:
            break
        }
        
    }
    
    private func pushNoResultsController() {
        let errorController = ErrorController(message: Constants.genericNoConnectionMessage, buttonTitle: Constants.backtext) {
            ///DidTapActionButtonHandler
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(errorController, animated: true)
    }
    
    private func setupContraints() {
        listSelector.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: Constants.sidePadding, bottom: 0, right: Constants.sidePadding))
        listControllersContainer.anchor(top: listSelector.bottomAnchor, leading: view.leadingAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    var didTapComletionHandler: ((String, Location) -> ())?
    
    private func setupDidTapPlaceHandler() {
        didTapComletionHandler = { [weak self] placeId, location in  //Don't think location this is used
            guard let location = self?.location else { return }
            let detailController = PlaceDetailsController(placeId: placeId, location: location)
            self?.navigationController?.pushViewController(detailController, animated: true)
        }
        
        favouritesController.didSelectPlaceInListHandler = didTapComletionHandler
        toDoController.didSelectPlaceInListHandler = didTapComletionHandler
    }
}


@nonobjc fileprivate extension UIViewController {
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
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
