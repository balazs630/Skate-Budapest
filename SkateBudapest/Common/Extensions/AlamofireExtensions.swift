//
//  AlamofireExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 06. 30..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Alamofire

extension DataRequest {
    @discardableResult
    public func log() -> Self {
        Log.debug(self)
        return self
    }
}

extension DataResponse {
    @discardableResult
    public func log() -> DataResponse {
        Log.debug(self)
        return self
    }
}
