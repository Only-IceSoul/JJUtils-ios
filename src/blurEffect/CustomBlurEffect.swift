//
//  File.swift
//  jjutils_Example
//
//  Created by Juan J LF on 5/2/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public class CustomBlurEffect: UIBlurEffect {
    
    public var blurRadius: CGFloat = 10.0
    public var colorTint : UIColor?
    public var colorTintAlpha : CGFloat = 1
    public var saturationDeltaFactor : CGFloat = 1.8
    
    private enum Constants {
        static let blurRadiusSettingKey = "blurRadius"
        static let colorTint = "colorTint"
        static let colorTintAlpha = "colorTintAlpha"
        static let saturationDeltaFactor = "saturationDeltaFactor"
    }
    
    class func effect(with style: UIBlurEffect.Style) -> CustomBlurEffect {
        let result = super.init(style: style)
        object_setClass(result, self)
        return result as! CustomBlurEffect
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let result = super.copy(with: zone)
        object_setClass(result, Self.self)
        return result
    }
    
    override public var effectSettings: AnyObject {
        get {
            let settings = super.effectSettings
            settings.setValue(blurRadius, forKey: Constants.blurRadiusSettingKey)
//            settings.setValue(UIColor.red.cgColor, forKey: Constants.colorTint)
            print("values \(String(describing: settings.allValues))")
            return settings
        }
        set {
            super.effectSettings = newValue
        }
    }
    
}
