//
//  JJShapeLayer.swift
//  AnimationPractica
//
//  Created by Juan J LF on 3/24/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    
    
    /**
     * 
     *  Transform layer with anchor point, require bounds setted
     *
     * - Parameters:
     *    - point: new anchor point
    */
    @discardableResult
    func setAnchorPoint(_ point: CGPoint)  -> CAShapeLayer {
        if bounds == .zero { return self }
          anchorPoint = CGPoint(x: 0, y: 0)
        guard let parent = superlayer else {return self}
        
        var newPoint = CGPoint(x: parent.bounds.size.width * point.x, y: parent.bounds.size.height * point.y)
        var oldPoint = CGPoint(x: parent.bounds.size.width * anchorPoint.x, y: parent.bounds.size.height * anchorPoint.y);

           newPoint = newPoint.applying(affineTransform())
           oldPoint = oldPoint.applying(affineTransform())
        
           position.x -= oldPoint.x
           position.x += newPoint.x

           position.y -= oldPoint.y
           position.y += newPoint.y
           anchorPoint = point
           return self
    }
    
    /**
       *
       *  require bounds setted to work
       *
      */
    @discardableResult
    func setAnchorPointToCenter() -> CAShapeLayer{
        setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
        return self
    }
    
}
