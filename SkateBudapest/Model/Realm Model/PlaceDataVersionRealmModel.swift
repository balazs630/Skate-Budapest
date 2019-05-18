//
//  PlaceDataVersionRealmModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import RealmSwift

final class PlaceDataVersionRealmModel: Object {
    @objc dynamic var dataVersion = ""

    override class func primaryKey() -> String? {
        return "dataVersion"
    }
}

// MARK: Initializers
extension PlaceDataVersionRealmModel {
    convenience init(_ placeDataVersionApiModel: PlaceDataVersionApiModel) {
        self.init()
        self.dataVersion = placeDataVersionApiModel.dataVersion
    }
}
