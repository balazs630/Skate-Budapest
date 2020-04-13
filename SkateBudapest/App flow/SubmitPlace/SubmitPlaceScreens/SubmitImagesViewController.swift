//
//  SubmitImagesViewController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class SubmitImagesViewController: UIViewController, StoryboardLoadable {
    // MARK: Properties
    weak var coordinator: SubmitPlaceCoordinator?
    var placeSuggestionDisplayItem: PlaceSuggestionDisplayItem?
    private var currentImageView: ImageViewPicker?
    private lazy var mediaAlertController = MediaAlertController()

    // MARK: Outlets
    @IBOutlet weak var imageContainerStackView: UIStackView!
    @IBOutlet weak var imageView1: ImageViewPicker!
    @IBOutlet weak var imageView2: ImageViewPicker!
    @IBOutlet weak var imageView3: ImageViewPicker!
    @IBOutlet weak var imageView4: ImageViewPicker!
    @IBOutlet var imageViews: [ImageViewPicker]!

    @IBOutlet weak var descriptionLabel: DescriptionLabel!
    @IBOutlet weak var nextButton: Button!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent != nil {
            loadUserInput()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            saveUserInput()
            backToSubmitTextsScreen()
        }
    }

    // MARK: Screen configuration
    private func configureSelf() {
        configureNavigationBar()
        configureMediaAlertController()
        configureImageViews()
        configureLabels()
        configureButtons()
    }

    private func configureNavigationBar() {
        navigationItem.title = Texts.SubmitPlace.submitImagesNavBarTitle.localized
    }

    private func configureMediaAlertController() {
        mediaAlertController.delegate = self
        mediaAlertController.presenter = self

        mediaAlertController.addDeleteAlertAction { [weak self] in
            guard let `self` = self else { return }

            self.updateImage(to: nil)
            self.currentImageView?.showPlaceHolder = true
        }
    }

    private func configureImageViews() {
        imageContainerStackView.layoutIfNeeded()
        NSLayoutConstraint.activate([
            imageContainerStackView.heightAnchor.constraint(equalToConstant: imageContainerStackView.frame.width)
        ])
    }

    private func configureLabels() {
        descriptionLabel.text = Texts.SubmitPlace.submitImagesDescription.localized
    }

    private func configureButtons() {
        nextButton.style = .next
        nextButton.setTitle(Texts.SubmitPlace.next.localized, for: .normal)
    }

    // MARK: Actions
    @IBAction func nextButtonTap(_ sender: Any) {
        do {
            try validateInput()
            saveUserInput()
            toSubmitPositionScreen()
        } catch let error as ValidationError {
            ResultAlertDialog(title: error.title, message: error.message).show()
        } catch { }
    }

    @IBAction func imageViewTap(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? ImageViewPicker else { return }
        currentImageView = imageView
        present(mediaAlertController, animated: true)
    }
}

// MARK: User input handling
extension SubmitImagesViewController {
    private func validateInput() throws {
        try [imageView1, imageView2].forEach { view in
            try view.validate(.imageIsRequired)
        }

        try imageViews.forEach { view in
            try view.validate(.imageSizeBiggerThan(CGSize(width: 600, height: 600)))
        }
    }

    private func saveUserInput() {
        placeSuggestionDisplayItem?.image1 = imageView1.image ?? UIImage()
        placeSuggestionDisplayItem?.image2 = imageView2.image ?? UIImage()
        placeSuggestionDisplayItem?.image3 = imageView3.image
        placeSuggestionDisplayItem?.image4 = imageView4.image
    }

    private func loadUserInput() {
        imageView1.image = placeSuggestionDisplayItem?.image1
        imageView2.image = placeSuggestionDisplayItem?.image2
        imageView3.image = placeSuggestionDisplayItem?.image3
        imageView4.image = placeSuggestionDisplayItem?.image4

        imageViews.forEach {
            $0.showPlaceHolderIfNeeded()
        }
    }

    private func updateImage(to image: UIImage?) {
        imageViews
            .filter { $0 == currentImageView }
            .first
            .map { $0.image = image }
    }
}

// MARK: Navigation
extension SubmitImagesViewController {
    private func toSubmitPositionScreen() {
        coordinator?.toSubmitPositionScreen(with: placeSuggestionDisplayItem)
    }

    private func backToSubmitTextsScreen() {
        coordinator?.backToSubmitTextsScreen(with: placeSuggestionDisplayItem)
    }
}

// MARK: UIImagePickerControllerDelegate methods
extension SubmitImagesViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

        currentImageView?.image = image.compress(rate: .low)
        currentImageView?.showPlaceHolder = false
        currentImageView?.clearValidationErrorBorder()
        updateImage(to: currentImageView?.image)

        picker.dismiss(animated: true)
    }
}

extension SubmitImagesViewController: UINavigationControllerDelegate { }
