//
//  PlaceInfoRealmModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import RealmSwift

class PlaceInfoRealmModel: Object {
    @objc dynamic var dataVersion = ""

    convenience init(dataVersion: String) {
        self.init()
        self.dataVersion = dataVersion
    }

    convenience init(_ placeInfoApiModel: PlaceInfoApiModel) {
        self.init()
        self.dataVersion = placeInfoApiModel.dataVersion
    }
}
