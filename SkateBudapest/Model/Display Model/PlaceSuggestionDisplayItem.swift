//
//  PlaceSuggestionDisplayItem.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 03. 15..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit
import CoreLocation

struct PlaceSuggestionDisplayItem {
    var name: String
    var info: String
    var type: String
    var senderEmail: String
    var image1: UIImage
    var image2: UIImage
    var image3: UIImage?
    var image4: UIImage?
    var coordinate: CLLocationCoordinate2D

    init(name: String = "",
         info: String = "",
         type: String = "",
         senderEmail: String = "",
         image1: UIImage = UIImage(),
         image2: UIImage = UIImage(),
         coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
        self.name = name
        self.info = info
        self.type = type
        self.senderEmail = senderEmail
        self.image1 = image1
        self.image2 = image2
        self.coordinate = coordinate
    }
}
