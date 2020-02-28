//
//  ToDoHolderCell.swift
//  DiscoverPlaces
//
//  Created by user on 28/02/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ToDoHolderCell: UICollectionViewCell {
    
    var listController = ToDoController()
    
       override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(listController.view)
        listController.view.fillSuperview()
    }
    
    func refreshData() {
        listController.refreshData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
