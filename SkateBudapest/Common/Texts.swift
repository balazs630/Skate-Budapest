//
//  Texts.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 24..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

struct Texts {
    enum General: String, Localizable {
        case ok
        case loading
        case uploading
        case back
        case cancel
        case delete
        case settings
        case update

        case photoLibrary
        case takePhoto
        case turnOnPhotosInSettings
        case turnOnCameraInSettings
        case permissionDenied
    }

    enum SkateMap: String, Localizable {
        case mapNavBarTitle
        case mapTabBarTitle

        case mapSegmentTitle
        case listSegmentTitle

        case filterScreenTitle
        case filterButtonTitle

        case updateDatabaseTitle
        case updateDatabaseMessage

        case skateparkType
        case streetspotType
        case skateshopType
    }

    enum PlaceDetails: String, Localizable {
        case mapNavigationEmptyViewText
        case mapNavigationEmptyViewButtonText
        case hour
        case minutes
        case directions
        case start
        case destination
    }

    enum PlaceReport: String, Localizable {
        case title
        case subTitle
        case email
        case reportNotes
        case send

        case successAlertTitle
        case successAlertMessage
    }

    enum SubmitPlace: String, Localizable {
        case submit
        case next
        case submitPlaceDescription
        case submitTypeDescription
        case submitTextsTitle
        case submitTextsDescription
        case submitTextsEmail
        case submitTextsEmailDescription
        case submitImagesDescription
        case submitPositionDescription
        case submitResultTitle

        case submitDescriptionNavBarTitle
        case submitTypeNavBarTitle
        case submitTextsNavBarTitle
        case submitImagesNavBarTitle
        case submitPositionNavBarTitle
        case submitResultNavBarTitle
    }

    enum Validation: String, Localizable {
        case invalidEmailFormat
        case imageRequired
        case imageSizeTooSmall
        case textTooShort
        case textTooLong
        case mustChangeCoordinates
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
