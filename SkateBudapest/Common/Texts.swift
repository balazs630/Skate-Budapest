//
//  Texts.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 24..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

struct Texts {
    enum General: String, Localizable {
        // swiftlint:disable:next identifier_name
        case ok
        case loading
        case cancel
        case delete
        case settings

        case photoLibrary
        case takePhoto
        case turnOnPhotosInSettings
        case turnOnCameraInSettings
        case permissionDenied
    }

    enum SkateMap: String, Localizable {
        case mapNavBarTitle
        case mapTabBarTitle

        case filterScreenTitle
        case filterTypeSkatepark
        case filterTypeSkatespot
        case filterTypeSkateshop
        case filterButtonTitle
    }

    enum LocationDetails: String, Localizable {
        case mapNavigationEmptyViewText
        case mapNavigationEmptyViewButtonText
        case hour
        case minutes
        case directions
        case start
        case destination
    }

    enum SubmitPlace: String, Localizable {
        case submit
        case submitTypeNavBarTitle
        case submitTextsNavBarTitle
        case submitImagesNavBarTitle
        case submitPositionNavBarTitle
        case submitSummaryNavBarTitle
    }

    enum Validation: String, Localizable {
        case invalidEmailFormat
        case imageRequired
        case imageSizeTooSmall
        case textTooShort
        case textTooLong
    }

    enum NetworkError: String, Localizable {
        case defaultTitle = "networkErrorTitle"
        case notConnectedToInternet = "notConnectedToInternetError"
        case networkConnectionLost = "networkConnectionLostError"
        case timedOut = "timedOutError"
        case unknown = "unknownNetworkError"
    }

    enum RealmError: String, Localizable {
        case defaultTitle = "realmErrorTitle"
        case dataNotExist = "dataNotExistError"
        case unknown = "unknownRealmError"
    }
}
