//
//  JJCircleProgressOriginalOriginal.swift
//  AnimationPractica
//
//  Created by Juan J LF on 3/27/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit

public class LayerCircleProgress: CAShapeLayer {


   private let mLayer = CAShapeLayer()
   private let mLayerBg = CAShapeLayer()
   private let mLayerReverse = CAShapeLayer()
   private let mLayerColor = CAGradientLayer()
   private let mLayerColorBg = CAGradientLayer()
   private let mLayerColorReverse = CAGradientLayer()
   private var mInset : CGFloat = 0

    private var mColors = [ UIColor.red.cgColor,UIColor.yellow.cgColor,UIColor.green.cgColor,UIColor.cyan.cgColor,
                            UIColor.blue.cgColor,UIColor.magenta.cgColor,UIColor.red.cgColor]
    private var mColorsBg = [ UIColor.lightGray.cgColor, UIColor.lightGray.cgColor]

    public override init() {
        super.init()
        addSublayers(mLayerColorBg,mLayerColorReverse,mLayerColor)
        
        mLayerColorBg.mask = mLayerBg
        mLayerColorReverse.mask = mLayerReverse
        mLayerColor.mask = mLayer
        
        mLayerColorBg.colors = mColorsBg
        mLayerColor.colors = mColors
        mLayerColorReverse.colors = mColors
        
        mLayerColorBg.startPoint = CGPoint(x: 0.5, y: 0.5)
        mLayerColorBg.endPoint = CGPoint(x: 1, y: 0.5)
        mLayerColor.startPoint = CGPoint(x: 0.5, y: 0.5)
        mLayerColor.endPoint = CGPoint(x: 1, y: 0.5)
        mLayerColorReverse.startPoint = CGPoint(x: 0.5, y: 0.5)
        mLayerColorReverse.endPoint = CGPoint(x: 1, y: 0.5)
        
        mLayerColorBg.type = CAGradientLayerType(rawValue: "conic")
        mLayerColor.type = CAGradientLayerType(rawValue: "conic")
        mLayerColorReverse.type = CAGradientLayerType(rawValue: "conic")
      
        mLayerBg.strokeColor = UIColor.systemPurple.cgColor
        mLayerBg.lineWidth = 6
        mLayerBg.lineCap = CAShapeLayerLineCap.round
        mLayerBg.fillColor = UIColor.clear.cgColor
      
        mLayer.strokeColor = UIColor.systemPurple.cgColor
        mLayer.lineWidth = 6
        mLayer.lineCap = CAShapeLayerLineCap.round
        mLayer.fillColor = UIColor.clear.cgColor
        mLayer.strokeEnd = 0
        mLayerReverse.strokeColor = UIColor.systemPurple.cgColor
        mLayerReverse.lineWidth = 6
        mLayerReverse.lineCap = CAShapeLayerLineCap.round
        mLayerReverse.fillColor = UIColor.clear.cgColor
        mLayerReverse.strokeEnd = 0
    }
    
    //MARK: SETTER GETTER
    
@discardableResult
    public func setStrokeWidth(_ size:CGFloat ) -> LayerCircleProgress{
        mLayer.lineWidth = size
        mLayerBg.lineWidth = size
        mLayerReverse.lineWidth = size
        return self
    }
   
   @discardableResult
    public func setCap(_ cap: CAShapeLayerLineCap)-> LayerCircleProgress {
       disableAnimation()
       mLayer.lineCap = cap
       mLayerReverse.lineCap = cap
       mLayerBg.lineCap = cap
       commit()
       return self
   }
    @discardableResult
    public func setColor(_ colors: [CGColor],positions:[NSNumber]? = nil)-> LayerCircleProgress {
        disableAnimation()
        mLayerColor.colors = colors
        mLayerColorReverse.colors = colors
        mLayerColor.locations = positions
        mLayerColorReverse.locations = positions
        commit()
        return self
    }

   @discardableResult
    public func setColor(_ color: CGColor?)-> LayerCircleProgress {
        let c = color == nil ? UIColor.clear.cgColor : color!
       disableAnimation()
       mLayerColor.colors = [c,c]
       mLayerColorReverse.colors = [c,c]
       commit()
       return self
   }
    @discardableResult
    public func setBackColor(_ colors: [CGColor],positions:[NSNumber]? = nil)-> LayerCircleProgress {
        disableAnimation()
        mLayerColorBg.colors = colors
        mLayerColorBg.locations = positions
        commit()
        return self
    }

   @discardableResult
    public func setBackColor(_ color: CGColor?)-> LayerCircleProgress {
       let c = color == nil ? UIColor.clear.cgColor : color!
       disableAnimation()
       mLayerColorBg.colors = [c,c]
       commit()
       return self
   }
   @discardableResult
    public func setProgress(_ progress: CGFloat)-> LayerCircleProgress {
       self.percent = progress
       setNeedsDisplay()
       return self
   }
  
   
    public func getPercent() -> CGFloat{ return percent }
    public func getBackColor() -> [Any]? { return mLayerColorBg.colors }
    public func getColor() ->  [Any]? { return mLayerColor.colors }
    public func getLineCap() -> CAShapeLayerLineCap { mLayer.lineCap }

  

   //MARK : PERCENT
   
   @objc public dynamic var percent : CGFloat = 0
   @objc public override class func needsDisplay(forKey key: String) -> Bool {
       if(key == #keyPath(LayerCircleProgress.percent)) { return true }

       return super.needsDisplay(forKey: key)
   }
    
    public override func display() {
       super.display()
       
       displayPercent()
   }
   private func displayPercent(){
       let value = self.presentation()?.percent ?? self.percent
       let p = value / 100
       disableAnimation()
       mLayer.strokeEnd = p > 0 ? p : 0
       mLayerReverse.strokeEnd = p < 0 ? p * -1 : 0
        mLayer.setNeedsDisplay()
       commit()
   }
    public override init(layer: Any) {
       super.init(layer: layer)
       if let ol = layer as? LayerCircleProgress { self.percent = ol.percent }
   }
   
   //MARK : BASE
   
   private var mMainRect = CGRect()
   private var mMainPath  = UIBezierPath()
   private var mPathReverse = UIBezierPath()
   private var mDegrees :CGFloat = 0
   private var mTransX : CGFloat = 0
   private var mTransY : CGFloat = 0
   private var mScale  : CGFloat = 1
    
   private func setupMainPath(){
    let radius = min(super.bounds.width,super.bounds.height) / 2 - mLayerBg.lineWidth / 2
        mMainPath.removeAllPoints()
        mMainPath.addArc(withCenter: super.bounds.center, radius: radius, startAngle: 0, endAngle: .pi*2, clockwise: true)
        mPathReverse.removeAllPoints()
        mPathReverse.addArc(withCenter: super.bounds.center, radius: radius, startAngle: .pi*2, endAngle: 0 , clockwise: false)
 
   }
   
    public func onBoundsChange(_ bounds: CGRect){
        invalidateFrame(bounds)
   }
   private func invalidatePath(){
       setupMainPath()
       mLayerBg.path = mMainPath.cgPath
       mLayer.path = mMainPath.cgPath
       mLayerReverse.path = mPathReverse.cgPath
    }
    private func invalidateFrame(_ bounds:CGRect){
        mMainRect.set(rect: bounds)
        mMainRect.setInset(dx: mInset, dy: mInset)
        super.frame = mMainRect
        mLayerColorReverse.frame = mMainRect
        mLayerColorBg.frame = mMainRect
        mLayerColor.frame = mMainRect
        invalidatePath()
        super.position.x = bounds.center.x
        super.position.y = bounds.center.y
        mLayerColorBg.position.x = mMainRect.width / 2
        mLayerColorBg.position.y = mMainRect.height / 2
        mLayerColor.position.x = mMainRect.width / 2
        mLayerColor.position.y = mMainRect.height / 2
        mLayerColorReverse.position.x = mMainRect.width / 2
        mLayerColorReverse.position.y = mMainRect.height / 2


     
    }
    @discardableResult
    public func setInset(_ inset:CGFloat) -> LayerCircleProgress{
      mInset = inset
      return self
    }
    @discardableResult
    public func setScale(scale:CGFloat)-> LayerCircleProgress {
        mScale = scale
        makeTransform()
        return self
    }
    @discardableResult
    public func setRotation(degrees: CGFloat) -> LayerCircleProgress{
        mDegrees = degrees
        makeTransform()
        return self
    }
    @discardableResult
    public func setTranslation(dx:CGFloat,dy:CGFloat)-> LayerCircleProgress {
        mTransX = dx
        mTransY = dy
        makeTransform()
        return self
    }
    public func getRotation() -> CGFloat { return mDegrees }
    public func getOffset() -> CGPoint { return .init(x: mTransX, y: mTransY) }
    public func getScale() -> CGFloat { return mScale }
    public func getInset() -> CGFloat { return mInset }
    private func makeTransform(_ animated:Bool = false){
        if(animated){
          applyTransform()
        }else {
         disableAnimation()
         applyTransform()
         commit()
        }
    }
 
    private func applyTransform(){
        let radian = (mDegrees * .pi) / 180
        var localTransfrom  = CATransform3DMakeTranslation(mTransX, mTransY, 0)
        localTransfrom = CATransform3DScale(localTransfrom, mScale, mScale, mScale)
        localTransfrom = CATransform3DRotate(localTransfrom, radian, 0, 0, 1)

        self.transform = localTransfrom
        self.mLayerColorBg.transform = localTransfrom
        self.mLayerColor.transform = localTransfrom
        self.mLayerColorReverse.transform = localTransfrom
    }

    public required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    private func disableAnimation(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
    }
    private func commit(){  CATransaction.commit() }
    
    
    public override var frame: CGRect { set{} get { return super.frame} }
    public override var transform: CATransform3D { set{ } get { return super.transform } }
    public override var path: CGPath? { set {} get { return super.path } }
}
