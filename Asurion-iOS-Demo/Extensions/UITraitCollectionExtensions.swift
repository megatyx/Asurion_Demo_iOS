//
//  UITraitCollectionExtensions.swift
//  Asurion-iOS-Demo
//
//  Created by Tyler Wells on 8/25/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import UIKit
extension UITraitCollection {

    var isIpad: Bool {
        return horizontalSizeClass == .regular && verticalSizeClass == .regular
    }

    var isIphoneLandscape: Bool {
        return verticalSizeClass == .compact
    }

    var isIphonePortrait: Bool {
        return horizontalSizeClass == .compact && verticalSizeClass == .regular
    }

    var isIphone: Bool {
        return isIphoneLandscape || isIphonePortrait
    }
}
