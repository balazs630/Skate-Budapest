//
//  PlaceCachingService.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class PlaceCachingService {
    private let placeWebService = PlaceWebService(environment: .production)
    private let realmService = RealmService()

    func getPlaces(completion: @escaping (Result<[PlaceDisplayItem]>) -> Void) {
        realmService.isPlacesDataPersisted { [weak self] isPlacesDataPersisted in
            guard let strongSelf = self else { return }

            if isPlacesDataPersisted {
                strongSelf.getFromDatabase(completion: completion)
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
        self.placeWebService.getPlaceInfo { result in
            switch result {
            case .success(let placeInfo):
                self.realmService.overwritePlacesInfo(with: placeInfo)
            case .failure(let error):
                completion(Result.failure(NetworkError(message: error.message)))
            }
        }

        self.placeWebService.getPlaces { result in
            switch result {
            case .success(let places):
                self.realmService.overwritePlaces(with: places)
                let placeDisplayItems = places.map { PlaceDisplayItem($0) }
                completion(Result.success(placeDisplayItems))
            case .failure(let error):
                completion(Result.failure(NetworkError(message: error.message)))
            }
        }
    }
}
