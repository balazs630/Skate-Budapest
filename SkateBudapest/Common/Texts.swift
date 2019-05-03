//
//  Texts.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 24..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

//swiftlint:disable next identifier_name

struct Texts {
    enum General: String, Localizable {
        case ok
        case loading
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
