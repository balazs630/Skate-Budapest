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
    private let placeWebService = PlaceWebService(environment: .production)
    private let realmService = RealmService()

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
                completion(Result.failure(RealmError(message: Texts.RealmError.dataNotExist)))
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
                let placeDisplayItems = places.map { PlaceDisplayItem($0) }
                completion(Result.success(placeDisplayItems))
            case .failure(let error):
                completion(Result.failure(NetworkError(message: error.message)))
            }
        }
    }

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
