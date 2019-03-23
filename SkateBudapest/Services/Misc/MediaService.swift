//
//  MediaService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 17..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Photos

class MediaService {
    // MARK: Properties
    static let shared = MediaService()

    // MARK: Initializers
    private init() { }
}

// MARK: Request permissions
extension MediaService {
    func requestPhotosPermission(_ closure: @escaping ((Bool) -> Void) ) {
        guard !isPhotosAccessGranted() else { return closure(true) }

        PHPhotoLibrary.requestAuthorization({ status in
            status == .authorized ? closure(true) : closure(false)
        })
    }

    func requestCameraPermission(_ closure: @escaping ((Bool) -> Void) ) {
        guard !isCameraAccessGranted() else { return closure(true) }

        AVCaptureDevice.requestAccess(for: .video) { granted in
            granted ? closure(true) : closure(false)
        }
    }
}

// MARK: Utility methods
extension MediaService {
    private func isPhotosAccessGranted() -> Bool {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        }
    }

    private func isCameraAccessGranted() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        }
    }
}
