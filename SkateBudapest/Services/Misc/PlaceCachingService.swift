//
//  PlaceCachingService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

//swiftlint:disable next empty_enum_arguments

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
            guard let strongSelf = self else { return }

            if isPlacesDataPersisted {
                strongSelf.isPlacesUpdateAvailable { [weak self] updateAvailable in
                    guard let strongSelf = self else { return }
                    if updateAvailable {
                        strongSelf.getFromNetwork(completion: completion)
                    } else {
                        strongSelf.getFromDatabase(completion: completion)
                    }
                }
            } else {
                strongSelf.getFromNetwork(completion: completion)
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
        self.placeWebService.getPlaceInfo { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let placeInfo):
                strongSelf.realmService.writePlacesInfo(with: placeInfo, update: true)
            case .failure(let error):
                completion(Result.failure(NetworkError(message: error.message)))
            }
        }

        self.placeWebService.getPlaces { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let places):
                strongSelf.realmService.writePlaces(with: places, update: true)
                strongSelf.getFromDatabase(completion: completion)
            case .failure(let error):
                completion(Result.failure(NetworkError(message: error.message)))
            }
        }
    }
}

// MARK: Utility
extension PlaceCachingService {
    private func isPlacesUpdateAvailable(completion: @escaping (Bool) -> Void) {
        placeWebService.getPlaceInfo { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let networkPlaceInfo):
                strongSelf.realmService.readPlaceInfo { realmPlaceDataVersion in
                    if realmPlaceDataVersion != networkPlaceInfo.dataVersion {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            case .failure(_):
                completion(false)
            }
        }
    }
}
