//
//  MKMapViewExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 05. 04..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import MapKit

extension MKMapView {
    func toggleUserTrackingMode() {
        switch userTrackingMode {
        case .none:
            setFollowTrackingMode()
        case .follow:
            setFollowWithHeadingTrackingMode()
        case .followWithHeading:
            setFollowTrackingMode()
        @unknown default:
            break
        }
    }

    func toggleMapTypeBetween(_ types: MKMapType...) {
        guard let currentTypeIndex = types.firstIndex(of: mapType) else { return }
        mapType = currentTypeIndex < types.count - 1 ? types[currentTypeIndex + 1] : types[0]
    }
}

// MARK: Utility methods
extension MKMapView {
    private func setFollowTrackingMode() {
        resetToNorth()
        setUserTrackingMode(.follow, animated: true)
    }

    private func setFollowWithHeadingTrackingMode() {
        setUserTrackingMode(.followWithHeading, animated: true)
    }

    private func resetToNorth() {
        let northCamera = camera
        northCamera.heading = 0
        setCamera(northCamera, animated: true)
    }
}
