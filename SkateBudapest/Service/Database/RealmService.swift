//
//  RealmService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 29..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

// swiftlint:disable force_try

import RealmSwift

class RealmService {
    // MARK: Properties
    fileprivate var realm: Realm { return try! Realm() }

    // MARK: Read/write processes
    func readPlaces(completion: @escaping (([PlaceDisplayItem]?) -> Void)) {
        let places = realm.objects(PlaceRealmModel.self)
        if Array(places).isEmpty {
            completion(nil)
        } else {
            completion(places.map { PlaceDisplayItem($0) })
        }
    }

    func readPlaceInfo(completion: @escaping (String?) -> Void) {
        let placeInfo = Array(realm.objects(PlaceInfoRealmModel.self))
        completion(placeInfo.first?.dataVersion)
    }

    func writePlaces(with places: [PlaceApiModel], update: Bool = false) {
        try! realm.write {
            realm.add(places.map { PlaceRealmModel($0) }, update: true)
        }
    }

    func writePlacesInfo(with placesInfo: PlaceInfoApiModel, update: Bool = false) {
        try! realm.write {
            realm.add(PlaceInfoRealmModel(placesInfo), update: true)
        }
    }
}

// MARK: Helper functions
extension RealmService {
    func isPlacesDataPersisted(completion: @escaping (Bool) -> Void) {
        isPlacesAvailable { isPlacesAvailable in
            self.isPlaceInfoAvailable { isPlaceInfoAvailable in
                if isPlacesAvailable && isPlaceInfoAvailable {
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

    private func isPlaceInfoAvailable(completion: @escaping (Bool) -> Void) {
        readPlaceInfo { result in
            completion(result != nil)
        }
    }
}
