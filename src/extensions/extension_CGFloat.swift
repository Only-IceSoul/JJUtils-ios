//
//  extension_CGFloat.swift
//  testany
//
//  Created by Juan J LF on 4/28/21.
//

import UIKit

public extension CGFloat {
    
    func toRadians()-> CGFloat{
        return (self * .pi) / 180
    }
    func toDegrees()-> CGFloat{
        return self * 180 / CGFloat.pi
    }
    
    func clamp(min:CGFloat = 0,max:CGFloat = 1) -> CGFloat{
        return self > max ? max : (self < min ? min : self)
    }
    func clampNotNegative()->CGFloat{
        return self < 0 ? 0 : self
    }
}

public extension Float {
    
    func toRadians()-> Float{
        return (self * .pi) / 180
    }
    func toDegrees()-> Float{
        return self * 180 / Float.pi
    }
    
    func clamp(min:Float = 0,max:Float = 1) -> Float{
        return self > max ? max : (self < min ? min : self)
    }
    func clampNotNegative()->Float{
        return self < 0 ? 0 : self
    }
}
