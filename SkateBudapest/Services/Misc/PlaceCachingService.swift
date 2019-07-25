//
//  PlaceCachingService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class PlaceCachingService {
    // MARK: Properties
    private let placeWebService = PlaceWebService()
    private let realmService = RealmService()
}

// MARK: Retrieve data from network or database
extension PlaceCachingService {
    func getPlaces(completion: @escaping (Result<[PlaceDisplayItem]>) -> Void) {
        realmService.isPlacesDataPersisted { [weak self] isPlacesDataPersisted in
            guard let `self` = self else { return }

            if isPlacesDataPersisted {
                self.isPlacesUpdateAvailable { [weak self] updateAvailable in
                    guard let `self` = self else { return }
                    if updateAvailable {
                        self.getFromNetwork(completion: completion)
                    } else {
                        self.getFromDatabase(completion: completion)
                    }
                }
            } else {
                self.getFromNetwork(completion: completion)
            }
        }
    }

    private func getFromDatabase(completion: @escaping (Result<[PlaceDisplayItem]>) -> Void) {
        self.realmService.readPlaces { result in
            if let result = result {
                completion(Result.success(result))
            } else {
                completion(Result.failure(RealmError(message: Texts.RealmError.dataNotExist.localized)))
            }
        }
    }

    private func getFromNetwork(completion: @escaping (Result<[PlaceDisplayItem]>) -> Void) {
        self.placeWebService.getPlaceDataVersion { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case .success(let dataVersion):
                self.realmService.writePlaceDataVersion(dataVersion, update: true)
            case .failure(let error):
                completion(Result.failure(NetworkError(message: error.message)))
            }
        }

        self.placeWebService.getPlaces { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case .success(let places):
                self.realmService.writePlaces(places, update: true)
                self.getFromDatabase(completion: completion)
            case .failure(let error):
                completion(Result.failure(NetworkError(message: error.message)))
            }
        }
    }
}

// MARK: Utility
extension PlaceCachingService {
    private func isPlacesUpdateAvailable(completion: @escaping (Bool) -> Void) {
        placeWebService.getPlaceDataVersion { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case .success(let networkPlaceDataVersion):
                self.realmService.readPlaceDataVersion { realmPlaceDataVersion in
                    if realmPlaceDataVersion != networkPlaceDataVersion.dataVersion {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            case .failure:
                completion(false)
            }
        }
    }
}
