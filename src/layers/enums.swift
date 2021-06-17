//
//  enums.swift
//  jjutils
//
//  Created by Juan J LF on 6/17/21.
//

import Foundation


public enum DrawableLineCap : String{
    case butt,
         round,
         square
    
    internal func toTarget() -> CAShapeLayerLineCap
    {
        return CAShapeLayerLineCap.init(rawValue: rawValue)
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

