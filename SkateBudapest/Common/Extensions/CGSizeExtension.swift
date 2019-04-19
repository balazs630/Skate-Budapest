//
//  CGSizeExtension.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2019. 04. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import CoreGraphics

extension CGSize {
    func isGreaterOrEqual(to size: CGSize) -> Bool {
        return width >= size.width || height >= size.height
    }
}
