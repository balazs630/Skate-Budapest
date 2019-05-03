//
//  Localizable.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 24..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
    func localizedWithParameter(_ orderedParameters: CVarArg...) -> String
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var tableName: String {
        return "Localizable"
    }

    var localized: String {
        return rawValue.localized()
    }

    func localizedWithParameter(_ orderedParameters: CVarArg...) -> String {
        return String(format: localized, arguments: orderedParameters)
    }
}
