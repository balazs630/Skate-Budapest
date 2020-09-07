//
//  EmptyDataViewController.swift
//  SkateBudapest
//
//  Created by Balázs Horváth on 2020. 09. 07..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

class EmptyDataViewController: UIViewController {
    // MARK: Properties
    private var titleLabel = UILabel()
    private var retryButton = UIButton()
    private var retryButtonAction: () -> Void

    // MARK: Initializers
    init(title: String, action: @escaping () -> Void) {
        titleLabel.text = title
        retryButtonAction = action

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitleLabel()
        configureRetryButton()
        setupLayout()
    }

    // MARK: Setup views
    private func configureTitleLabel() {
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }

    private func configureRetryButton() {
        retryButton.setTitle(Texts.SkateMap.emptyListRetryButtonTitle.localized, for: .normal)
        retryButton.setTitleColor(.lightGray, for: .normal)
        retryButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)

        retryButton.layer.borderWidth = 1.5
        retryButton.layer.cornerRadius = 5
        retryButton.layer.borderColor = UIColor.lightGray.cgColor

        retryButton.addTarget(self, action: #selector(retryButtonDidTap), for: .touchUpInside)
    }

    private func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        view.addSubview(retryButton)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }

    // MARK: Actions
    @objc private func retryButtonDidTap() {
        retryButtonAction()
    }
}
