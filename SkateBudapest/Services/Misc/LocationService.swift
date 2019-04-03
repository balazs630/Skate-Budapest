//
//  LocationService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import CoreLocation

class LocationService: NSObject {
    // MARK: Properties
    static let shared = LocationService()
    private var locationManager: CLLocationManager

    var location: CLLocation? {
        return locationManager.location
    }

    var coordinates: CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }

    // MARK: Initializers
    private override init() {
        locationManager = CLLocationManager()
        super.init()
    }
}

// MARK: Utility methods
extension LocationService {
    func startTracking() {
        requestLocationPermission()
        locationManager.startUpdatingLocation()
    }

    private func requestLocationPermission() {
        if !isAccessGranted() {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    private func isAccessGranted() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }
}

// MARK: CLLocationManagerDelegate methods
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        debugPrint(error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            locationManager.stopUpdatingLocation()
        case .notDetermined, .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
}
