//
//  RealmService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 29..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import RealmSwift

class RealmService {
    // MARK: Properties
    fileprivate var realm: Realm? { return try? Realm() }

    // MARK: Read/write processes
    func readPlaces(completion: @escaping (([PlaceDisplayItem]?) -> Void)) {
        guard let places = realm?.objects(PlaceRealmModel.self) else { return }
        if places.isEmpty {
            completion(nil)
        } else {
            completion(places.map { PlaceDisplayItem($0) })
        }
    }

    func readPlaceDataVersion(completion: @escaping (String?) -> Void) {
        guard let placeDataVersion = realm?.objects(PlaceDataVersionRealmModel.self) else { return }
        completion(placeDataVersion.first?.dataVersion)
    }

    func writePlaces(with places: [PlaceApiModel], update: Bool = false) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(places.map { PlaceRealmModel($0) }, update: update)
        }
    }

    func writePlaceDataVersion(with placeDataVersion: PlaceDataVersionApiModel, update: Bool = false) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(PlaceDataVersionRealmModel(placeDataVersion), update: update)
        }
    }
}

// MARK: Helper functions
extension RealmService {
    func isPlacesDataPersisted(completion: @escaping (Bool) -> Void) {
        isPlacesAvailable { [weak self] isPlacesAvailable in
            guard let `self` = self else { return }

            self.isPlaceDataVersionAvailable { isPlaceDataVersionAvailable in
                if isPlacesAvailable, isPlaceDataVersionAvailable {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }

    private func isPlacesAvailable(completion: @escaping (Bool) -> Void) {
        self.readPlaces { result in
            completion(result != nil)
        }
    }

    private func isPlaceDataVersionAvailable(completion: @escaping (Bool) -> Void) {
        readPlaceDataVersion { result in
            completion(result != nil)
        }
    }
}
