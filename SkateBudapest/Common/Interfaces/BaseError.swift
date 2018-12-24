//
//  BaseError.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 11..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

protocol BaseError: Error {
    var title: String { get }
    var message: String { get }
}
