//
//  LoadingViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 19..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    // MARK: Properties
    private var titleText: String = ""
    private lazy var titleLabel = UILabel()
    private lazy var activityIndicator = UIActivityIndicatorView()
    private lazy var containerView = UIView()

    // MARK: Initializers
    init(title: String) {
        self.titleText = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Screen configuration
    private func configureSelf() {
        configureContainerView()
        configureActivityIndicator()
        configureTitleLabel()
    }
}

// MARK: Appearance
extension LoadingViewController {
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = Theme.Color.loadingViewDark
        containerView.layer.opacity = 0.92
        containerView.layer.cornerRadius = 12.0

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 150),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureActivityIndicator() {
        containerView.addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.startAnimating()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -10)
        ])
    }

    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = titleText
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 120),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 4),
            titleLabel.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor)
        ])
    }
}
