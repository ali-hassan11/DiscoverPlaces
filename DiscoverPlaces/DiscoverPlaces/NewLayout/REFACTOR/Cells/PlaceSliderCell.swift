//
//  PlaceSliderCell.swift
//  DiscoverPlaces
//
//  Created by user on 28/08/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class PlaceSliderCell:  UITableViewCell, NibLoadableReusable, DetailCellConfigurable {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var sliderControllerContainer: UIView!
    
    var sliderController: HorizontalSnappingController?
    
    @IBOutlet weak var sliderControllerHeight: NSLayoutConstraint!
    
    func configure(using viewModel: DetailItemViewModelType) {
        guard let viewModel = viewModel as? PlacesSliderViewModel else { return }
        
        sectionTitleLabel.attributedText = viewModel.sectionTitle
        sliderControllerContainer.backgroundColor = viewModel.theming.cellBackground
        sliderControllerHeight.constant = viewModel.sectionHeight

        selectionStyle = .none
        
        configureSliderController(using: viewModel)
    }
    
    private var shouldAddPlacesController = true
    private func configureSliderController(using viewModel: PlacesSliderViewModel) {
        
        let placesController = PlaceGroupHorizontalController(results: viewModel.places, didSelectHandler: viewModel.didSelectPlaceAction)
        
        guard shouldAddPlacesController == true else { return }
        shouldAddPlacesController = false
        removeSliderContainerSubviews()
        
        sliderController = placesController
        guard let sliderController = sliderController else { return }
        sliderControllerContainer.addSubview(sliderController.view)
        sliderController.view.fillSuperview()
    }
    
    private func removeSliderContainerSubviews() {
        sliderControllerContainer.subviews.forEach { $0.removeFromSuperview() }
    }
}
