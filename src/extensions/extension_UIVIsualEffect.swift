//
//  extension_UIVIsualEffect.swift
//  jjutils_Example
//
//  Created by Juan J LF on 5/2/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

private var AssociatedObjectHandle: UInt8 = 0

extension UIVisualEffect {
    @objc var effectSettings: AnyObject {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as AnyObject
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
