//
//  PlaceInfoRealmModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import RealmSwift

final class PlaceInfoRealmModel: Object {
    @objc dynamic var dataVersion = ""

    override class func primaryKey() -> String? {
        return "dataVersion"
    }
}

// MARK: Initializers
extension PlaceInfoRealmModel {
    convenience init(_ placeInfoApiModel: PlaceInfoApiModel) {
        self.init()
        self.dataVersion = placeInfoApiModel.dataVersion
    }
}
