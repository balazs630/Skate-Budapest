//
//  LocationManager.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject {
    // MARK: Properties
    static let shared = LocationManager()
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
        requestAuthorization()
    }
}

// MARK: Utility methods
extension LocationManager {
    func requestAuthorization() {
        if !locationGranted() {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func startTracking() {
        locationManager.startUpdatingLocation()
    }

    func locationGranted() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        }
    }
}

// MARK: CLLocationManagerDelegate methods
extension LocationManager: CLLocationManagerDelegate {
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
        }
    }
}
