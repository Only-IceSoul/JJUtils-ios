//
//  DrawableView.swift
//  testany
//
//  Created by Juan J LF on 4/26/21.
//

import UIKit
import jjutils
class DrawableView: UIView {
    
 
    let mBg = GradientDrawable(type: .radial)
    let mPath = JJDrawable()
    
    let other = "M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"
    init() {
        super.init(frame: .zero)
        
        layer.mask = mPath
        layer.addSublayer(mBg)
        
//        let v = UIView()
//        addSubview(v)
//        v.translatesAutoresizingMaskIntoConstraints = false
//
//        v.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        v.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        v.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        v.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//
//        v.backgroundColor = UIColor.blue
//        layer.backgroundColor = UIColor.red.cgColor
        
        
  
        


        mBg.setColor([UIColor.red.cgColor,UIColor.blue.cgColor,UIColor.white.cgColor])
            .setPositions([0,0.5,1])
            .setStartPoint(CGPoint.init(x: 0.5, y: 0.5))
            .setEndPoint(CGPoint.init(x: 1, y: 1))
//            .setBoundsDynamically(x: 0.25, y: 0.25, width: 0.5, height: 0.5, percentPos: true, percentSize: true)

        mPath .setFillColor(c: UIColor.white.cgColor)

            .setSvgPath(d: other,viewBox: [0,0,24,24])
            .setShape(s: .svgPath)


        
    }
    
    func setStrokeEnd(_ v :CGFloat){
//        mBg.setStrokeEnd(e: v)
        mBg.invalidateSelf()
    }
    
    override var bounds: CGRect{
        didSet{
            mBg.onBoundsChange(bounds)
            mPath.onBoundsChange(bounds)
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
