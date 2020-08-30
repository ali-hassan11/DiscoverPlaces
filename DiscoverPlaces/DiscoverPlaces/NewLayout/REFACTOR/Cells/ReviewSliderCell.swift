//
//  ReviewSliderCell.swift
//  DiscoverPlaces
//
//  Created by user on 28/08/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

final class ReviewSliderCell:  UITableViewCell, NibLoadableReusable, DetailCellConfigurable {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var sliderControllerContainer: UIView!
    
    var sliderController: HorizontalSnappingController?
    
    @IBOutlet weak var sliderControllerHeight: NSLayoutConstraint!

    func configure(using viewModel: DetailItemViewModelType) {
        guard let viewModel = viewModel as? ReviewsSliderViewModel else { return }
        
        sectionTitleLabel.attributedText = viewModel.sectionTitle
        sliderControllerContainer.backgroundColor = viewModel.theming.cellBackground
        sliderControllerHeight.constant = viewModel.sectionHeight
        
        selectionStyle = .none
        
        configureSliderController(using: viewModel)
    }
    
    private var shouldAddReviews = true
    private func configureSliderController(using viewModel: ReviewsSliderViewModel) {
        
        let reviewsController = ReviewsHorizontalController(reviews: viewModel.reviews, didSelectHandler: viewModel.didSelectReviewAction)
        
        guard shouldAddReviews == true else { return }
        shouldAddReviews = false
        removeSliderContainerSubviews()

        sliderController = reviewsController
        guard let sliderController = sliderController else { return }
        sliderControllerContainer.addSubview(sliderController.view)
        sliderController.view.fillSuperview()
    }
    
    private func removeSliderContainerSubviews() {
        sliderControllerContainer.subviews.forEach { $0.removeFromSuperview() }
    }
}
