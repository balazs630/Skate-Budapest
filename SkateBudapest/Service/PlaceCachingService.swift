//
//  PlaceCachingService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

// swiftlint:disable next empty_enum_arguments

import Foundation

class PlaceCachingService {
    private let placeWebService = PlaceWebService ()
    private let realmService = RealmService()

    func getPlaces(completion: @escaping ([PlaceDisplayItem]) -> Void) {
        realmService.isPlacesDataPersisted { [weak self] isPlacesDataPersisted in
            guard let strongSelf = self else { return }

            if isPlacesDataPersisted {
                strongSelf.getFromDatabase(completion: completion)
            } else {
                strongSelf.getFromNetwork(completion: completion)
            }
        }
    }

    private func getFromDatabase(completion: @escaping ([PlaceDisplayItem]) -> Void) {
        self.realmService.readPlaces { result in
            if let result = result {
                completion(result)
            }
            // TODO: Error handling
        }
    }

    private func getFromNetwork(completion: @escaping ([PlaceDisplayItem]) -> Void) {
        self.placeWebService.getPlaceInfo { result in
            switch result {
            case .success(let placeInfo):
                self.realmService.overwritePlacesInfo(with: placeInfo)
            case .failure(_):
                // TODO: Error handling
                break
            }
        }

        self.placeWebService.getPlaces { result in
            switch result {
            case .success(let places):
                self.realmService.overwritePlaces(with: places)
                completion(places.map { PlaceDisplayItem($0) })
            case .failure(_):
                // TODO: Error handling
                break
            }
        }
    }
}
