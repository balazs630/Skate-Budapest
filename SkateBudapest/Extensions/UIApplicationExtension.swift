//
//  UIApplicationExtension.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 11. 17..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIApplication {
    struct SafeAreaInset {
        static var bottom: CGFloat {
            if #available(iOS 11.0, *) {
                return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            } else {
                return 0
            }
        }
    }
}
