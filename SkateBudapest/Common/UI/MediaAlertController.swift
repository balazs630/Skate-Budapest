//
//  MediaAlertController.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 05. 19..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

class MediaAlertController: UIAlertController {
    // MARK: Properties
    private let mediaPermissionService = MediaPermissionService()
    weak var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    var presenter: UIViewController?

    // MARK: Initializers
    public init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        addPhotoLibraryAlertAction()
        addCameraAlertAction()
        addCancelAlertAction()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not yet implemented!")
    }
}

// MARK: - Alert actions
extension MediaAlertController {
    public func addPhotoLibraryAlertAction() {
        let alertAction = UIAlertAction(title: Texts.General.photoLibrary.localized, style: .default, handler: { _ in
            self.mediaPermissionService.requestPhotosPermission { granted in
                guard granted else {
                    self.showSettingsAlert(Texts.General.turnOnPhotosInSettings.localized)
                    return
                }
                DispatchQueue.main.async {
                    self.presentPhotoLibrary()
                }
            }
        })

        addAction(alertAction)
    }

    public func addCameraAlertAction() {
        let alertAction = UIAlertAction(title: Texts.General.takePhoto.localized, style: .default, handler: { _ in
            self.mediaPermissionService.requestCameraPermission { granted in
                guard granted else {
                    self.showSettingsAlert(Texts.General.turnOnCameraInSettings.localized)
                    return
                }
                DispatchQueue.main.async {
                    self.presentCamera()
                }
            }
        })

        addAction(alertAction)
    }

    public func addDeleteAlertAction(_ closure: @escaping (() -> Void)) {
        let alertAction = UIAlertAction(title: Texts.General.delete.localized,
                                        style: .destructive,
                                        handler: { _ in closure() })
        addAction(alertAction)
    }

    public func addCancelAlertAction() {
        let alertAction = UIAlertAction(title: Texts.General.cancel.localized, style: .cancel, handler: nil)
        addAction(alertAction)
    }

    private func showSettingsAlert(_ message: String) {
        let openSettingsAction = UIAlertAction(title: Texts.General.settings.localized, style: .default, handler: { _ in
            UIApplication.openSettings()
        })

        let alertController = ActionAlertDialog.build(title: Texts.General.permissionDenied.localized,
                                                      message: message,
                                                      primaryAction: openSettingsAction)

        presenter?.present(alertController, animated: true)
    }
}

// MARK: - Navigation
extension MediaAlertController {
    private func presentPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        guard let delegate = delegate else { return }

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
        imagePicker.sourceType = .photoLibrary

        presenter?.present(imagePicker, animated: true)
    }

    private func presentCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        guard let delegate = delegate else { return }

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false

        presenter?.present(imagePicker, animated: true)
    }
}