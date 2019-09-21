//
//  AlamofireExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 30..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Alamofire

extension DataRequest {
    public func log() {
        Log.debug(self)
    }
}

extension DataResponse {
    public func log() {
        Log.debug(self)
    }
}
