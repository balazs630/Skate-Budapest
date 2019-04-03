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
    private var currentImageView: UIImageView?
    private lazy var imagePickerController = UIImagePickerController()

    // MARK: Outlets
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!

    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        loadUserInput()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            saveUserInput()
            coordinator?.updateSubmitTextsScreen(with: placeSuggestionDisplayItem)
        }
    }

    // MARK: Screen configuration
    private func configureSelf() {
        navigationItem.title = Texts.SubmitPlace.submitImagesNavBarTitle.localized
    }

    // MARK: Actions:
    @IBAction func nextButtonTap(_ sender: Any) {
        saveUserInput()
        coordinator?.toSubmitPositionScreen(with: placeSuggestionDisplayItem)
    }

    @IBAction func imageViewTap(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        currentImageView = imageView

        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }
}

// MARK: User input handling
extension SubmitImagesViewController {
    private func saveUserInput() {
        placeSuggestionDisplayItem?.image1 = imageView1.image!
        placeSuggestionDisplayItem?.image2 = imageView2.image!
        placeSuggestionDisplayItem?.image3 = imageView3.image
        placeSuggestionDisplayItem?.image4 = imageView4.image
    }

    private func loadUserInput() {
        imageView1.image = placeSuggestionDisplayItem?.image1
        imageView2.image = placeSuggestionDisplayItem?.image2
        imageView3.image = placeSuggestionDisplayItem?.image3
        imageView4.image = placeSuggestionDisplayItem?.image4
    }
}

// MARK: UIImagePickerControllerDelegate methods
extension SubmitImagesViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        currentImageView?.image = image.compressSizeBelow(kiloByte: 300)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SubmitImagesViewController: UINavigationControllerDelegate { }
