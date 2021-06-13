//
//  DrawableView.swift
//  testany
//
//  Created by Juan J LF on 4/26/21.
//

import UIKit
import jjutils
import CoreImage
import CoreImage.CIFilterBuiltins
class DrawableView: UIView {
    
 
    let mBg = JJDrawable()
    
    let cabeza = "M45.09,10.69a29,29,0,0,0-29,29s-1.39,12.88,11.11,26.4V89.37H59.62v-12h10.3a6.25,6.25,0,0,0,6.25-6.25V60.71c2.3-.52,8.05-2.68,7.83-4.56-.25-2.15-6.57-16.42-6.57-16.42C71.87,7.91,45.09,10.69,45.09,10.69Z"
    let cabezaPart = "M45.09,10.69a29,29,0,0,0-29,29"
    let other = "M18.258,3.266c-0.693,0.405-1.46,0.698-2.277,0.857c-0.653-0.686-1.586-1.115-2.618-1.115c-1.98,0-3.586,1.581-3.586,3.53c0,0.276,0.031,0.545,0.092,0.805C6.888,7.195,4.245,5.79,2.476,3.654C2.167,4.176,1.99,4.781,1.99,5.429c0,1.224,0.633,2.305,1.596,2.938C2.999,8.349,2.445,8.19,1.961,7.925C1.96,7.94,1.96,7.954,1.96,7.97c0,1.71,1.237,3.138,2.877,3.462c-0.301,0.08-0.617,0.123-0.945,0.123c-0.23,0-0.456-0.021-0.674-0.062c0.456,1.402,1.781,2.422,3.35,2.451c-1.228,0.947-2.773,1.512-4.454,1.512c-0.291,0-0.575-0.016-0.855-0.049c1.588,1,3.473,1.586,5.498,1.586c6.598,0,10.205-5.379,10.205-10.045c0-0.153-0.003-0.305-0.01-0.456c0.7-0.499,1.308-1.12,1.789-1.827c-0.644,0.28-1.334,0.469-2.06,0.555C17.422,4.782,17.99,4.091,18.258,3.266"
    init() {
        super.init(frame: .zero)
        

        layer.addSublayer(mBg)
        
        
        
//        backgroundColor = UIColor.clear
//        layer.backgroundColor = UIColor.clear.cgColor
//        mBg.backgroundColor = UIColor.clear.cgColor
//
//        mBg
//            .setFillColor(c: Color.RED)
//            .setSvgPath(d: other,viewBox: [0,0,20,20])
//            .setShape(s: .svgPath)
////            .setBlur(radius: 1)
////            .setBackgroundColor(c: UIColor.blue.cgColor)
////            .setShadowOpacity(o: 1)
////            .setShadowRadius(r: 10)
//            .setStrokeWidth(w: Float(10 / UIScreen.main.scale))
//            .setStrokeColor(color: Color.GREEN)
//            .setStrokeStart(s: 0.5)
//            .setStrokeEnd(e: 0.8)
//            .setStrokeStyle(style: .borderOutside)
//            .setFillBlur(radius: Float(12 / UIScreen.main.scale) *  1.8)
//            .setBorderBlur(radius: Float(12 / UIScreen.main.scale))
        
        mBg
            .setFillColor(c: UIColor.red.cgColor)
            .setSvgPath(d: other,viewBox: [0,0,20,20])
            .setShape(s: .svgPath)
//            .setStrokeStart(s: 0.5)
//            .setStrokeEnd(e: 0.8)
//            .setBlur(radius: 3)
            .setStrokeWidth(w: (22 / UIScreen.main.scale))
            .setStrokeColor(color: UIColor.green.cgColor)

    
        
    }
    
    func setStrokeEnd(_ v :CGFloat){
        mBg.setStrokeEnd(e: v)
        mBg.invalidateSelf()
    }
    
    override var bounds: CGRect{
        didSet{
            mBg.onBoundsChange(bounds)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        layer.backgroundColor = UIColor.red.cgColor
//        
//        let anim = CABasicAnimation(keyPath: #keyPath(JJFilteredDrawable.blur))
//
//        anim.fromValue = 0
//        anim.toValue =  1
//        anim.duration = 5
//        anim.repeatCount = .greatestFiniteMagnitude
//        anim.fillMode = kCAFillModeForwards
//        anim.isRemovedOnCompletion = false
//
//        mBg.add(anim, forKey: nil)
     
    }
}
