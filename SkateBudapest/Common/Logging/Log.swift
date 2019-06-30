//
//  Log.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 30..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

class Log {
    static func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        items.forEach {
            debugPrint($0, separator: separator, terminator: terminator)
        }
        #endif
    }
}
