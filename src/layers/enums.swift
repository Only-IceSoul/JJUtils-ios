//
//  enums.swift
//  jjutils
//
//  Created by Juan J LF on 6/17/21.
//

import Foundation

public enum DrawableAxis {
    case x, y , z
}

public enum DrawableLineCap : String{
    case butt,
         round,
         square
    
    internal func toTarget() -> CAShapeLayerLineCap
    {
        return CAShapeLayerLineCap.init(rawValue: rawValue)
    }
}

public enum GradientDrawableType : String{
    case axial,
         radial,
         conic
    internal func toTarget() -> CAGradientLayerType
    {
        return CAGradientLayerType(rawValue: rawValue)
    }
}

public enum DrawableLineJoin : String{
    case bevel,
         miter,
         round
    
    internal func toTarget() -> CAShapeLayerLineJoin
    {
        return CAShapeLayerLineJoin.init(rawValue: rawValue)
    }
}

