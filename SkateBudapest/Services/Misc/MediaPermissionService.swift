//
//  MediaPermissionService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 17..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Photos

class MediaPermissionService { }

// MARK: Request permissions
extension MediaPermissionService {
    func requestPhotosPermission(_ closure: @escaping ((Bool) -> Void) ) {
        guard !isPhotosAccessGranted() else { return closure(true) }

        PHPhotoLibrary.requestAuthorization { status in
            status == .authorized ? closure(true) : closure(false)
        }
    }

    func requestCameraPermission(_ closure: @escaping ((Bool) -> Void) ) {
        guard !isCameraAccessGranted() else { return closure(true) }

        AVCaptureDevice.requestAccess(for: .video) { granted in
            granted ? closure(true) : closure(false)
        }
    }
}

// MARK: Utility methods
extension MediaPermissionService {
    private func isPhotosAccessGranted() -> Bool {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }

    private func isCameraAccessGranted() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }
}
