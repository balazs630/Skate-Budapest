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
    private var actionButton = UIButton()
    private var configuration: EmptyDataConfiguration

    // MARK: Initializers
    init(configuration: EmptyDataConfiguration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Configuration
    private func configureSelf() {
        configureTitleLabel()
        setupConfigureTitleLabelLayout()

        guard configuration.hasActionButton else { return }
        configureActionButton()
        setupActionButtonLayout()
    }

    private func configureTitleLabel() {
        titleLabel.text = configuration.title
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
    }

    private func configureActionButton() {
        actionButton.setTitle(configuration.buttonTitle, for: .normal)
        actionButton.setTitleColor(.lightGray, for: .normal)
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)

        actionButton.layer.borderWidth = 1.5
        actionButton.layer.cornerRadius = 5
        actionButton.layer.borderColor = UIColor.lightGray.cgColor

        actionButton.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
    }

    // MARK: Setup layout
    private func setupConfigureTitleLabelLayout() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupActionButtonLayout() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }

    // MARK: Actions
    @objc private func actionButtonDidTap() {
        configuration.buttonAction()
    }
}
