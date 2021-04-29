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
    
    func normalized(min:CGFloat = 0,max:CGFloat = 1) -> CGFloat{
        return self > max ? max : (self < min ? min : self)
    }
    func normalizedNotNegative()->CGFloat{
        return self < 0 ? 0 : self
    }
}

