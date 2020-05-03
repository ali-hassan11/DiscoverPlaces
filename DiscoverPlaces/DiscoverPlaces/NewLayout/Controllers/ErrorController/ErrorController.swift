//
//  ErrorController.swift
//  DiscoverPlaces
//
//  Created by user on 03/05/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import UIKit

class ErrorController: UIViewController {
    
    private var titleLabel: UILabel?
    private var messageLabel: UILabel?
    private var actionButton: UIButton?
    private var didTapActionButtonHandler: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        actionButton?.addTarget(self, action: #selector(callHandlerClosure), for: .touchUpInside)
        setupStackView()
    }
    
    @objc private func callHandlerClosure() {
        didTapActionButtonHandler?()
    }
    
    init(title: String? = nil, message: String? = nil, buttonTitle: String, buttonHandler: @escaping (()->())) {
        super.init(nibName: nil, bundle: nil)

        if let title = title {
            titleLabel = UILabel(text: title, font: .boldSystemFont(ofSize: 19), color: .label, alignment: .center, numberOfLines: 0)
        }
        
        if let message = message {
            messageLabel = UILabel(text: message, font: .systemFont(ofSize: 18), color: .label, alignment: .center, numberOfLines: 0)
        }
        
            actionButton = UIButton(title: buttonTitle, textColor: .systemPink, width: nil, height: 40, font: .systemFont(ofSize: 17, weight: .medium), backgroundColor: nil, cornerRadius: nil)
            
            self.didTapActionButtonHandler = buttonHandler
    }
    
    private func setupStackView() {
        let stackView = VerticalStackView(arrangedSubviews: [], spacing: 16)
        stackView.alignment = .center
        addViews(to: stackView, views: titleLabel, messageLabel, actionButton)
        
        view.addSubview(stackView)
        stackView.centerInSuperview()
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 30, bottom: 0, right: 30))
    }
    
    private func addViews(to stackView: UIStackView, views: UIView?...) {
        views.forEach { (view) in
            if let view = view {
                stackView.addArrangedSubview(view)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
