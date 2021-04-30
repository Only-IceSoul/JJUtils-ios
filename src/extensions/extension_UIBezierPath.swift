//
//  extension_UIBezierPath.swift
//  AnimationPractica
//
//  Created by Juan J LF on 3/26/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit



extension UIBezierPath {
    

    func addRect(_ r:CGRect?){
        guard let rect = r else { return }
        let l = rect.origin.x
        let r = rect.origin.x + rect.width
        let b = rect.origin.y + rect.height
        let t = rect.origin.y
        move(to: CGPoint(x: l, y: t))
        addLine(to: CGPoint(x: r, y: t))
        addLine(to: CGPoint(x: r , y: b))
        addLine(to: CGPoint(x: l, y: b ))
        addLine(to:CGPoint(x: l, y: t))
        close()
    }
    
    func addRoundRect(_ r:CGRect?,radius:[CGFloat]){
        guard let rect = r else { return }
        
        let maxValue = min(rect.width, rect.height) / 2
        let rtl = (radius[0] > maxValue ? maxValue : radius[0]).normalizedNotNegative()
        let rtr = (radius[1] > maxValue ? maxValue : radius[1]).normalizedNotNegative()
        let rbl = (radius[2] > maxValue ? maxValue : radius[2]).normalizedNotNegative()
        let rbr = (radius[3] > maxValue ? maxValue : radius[3]).normalizedNotNegative()
        

        let l = rect.origin.x
        let r = rect.origin.x + rect.width
        let b = rect.origin.y + rect.height
        let t = rect.origin.y
        move(to: CGPoint(x: l + rtl, y: t) )
        
        addLine(to: CGPoint(x: r - rtr, y: t))
        addArc(withCenter: CGPoint(x: r - rtr, y: t + rtr), radius: rtr, startAngle: (3 * CGFloat.pi)  / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        addLine(to: CGPoint(x: r , y: b - rbr))
        addArc(withCenter: CGPoint(x: r - rbr, y: b - rbr), radius: rbr, startAngle: 0 , endAngle: CGFloat.pi / 2, clockwise: true)
        
        addLine(to: CGPoint(x: l + rbl, y: b))
        addArc(withCenter: CGPoint(x: l + rbl, y: b - rbl), radius: rbl, startAngle: CGFloat.pi / 2 , endAngle: CGFloat.pi, clockwise: true)
        
        
        addLine(to: CGPoint(x: l, y: t + rtl))
        addArc(withCenter: CGPoint(x: l + rtl, y: t + rtl), radius: rtl, startAngle: CGFloat.pi , endAngle: (3 * CGFloat.pi ) / 2, clockwise: true)
        
        close()
    }
    
}
