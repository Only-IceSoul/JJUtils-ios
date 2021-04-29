//
//  JJLayerClipOriginalOriginal.swift
//  AnimationPractica
//
//  Created by Juan J LF on 3/27/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit


public class LayerClip : CAShapeLayer {
    

    private var mGravity : Gravity = .bottom
    private var mClosure : ((CGRect,UIBezierPath) -> Void)?
    private var mInset : CGFloat = 0
    private var mIsMainPathEnabled = true


    public convenience init(gravity: Gravity){
       self.init()
       mGravity = gravity
       setProgress(0)
       super.fillColor = UIColor.blue.cgColor
    }

    public override init() {
       super.init()
       setProgress(0)
       super.fillColor = UIColor.blue.cgColor
    }
    @discardableResult
    public func setIsMainPathEnabled(_ bool:Bool) -> LayerClip{
      mIsMainPathEnabled = bool
    return self
    }

    @discardableResult
    public func setGravity(_ gravity:Gravity)-> LayerClip {
       mGravity = gravity
       return self
    }
    @discardableResult
    public func setInset(inset : CGFloat)-> LayerClip{
       mInset = inset
       return self
    }
    @discardableResult
    public func setProgress(_ percent: CGFloat) -> LayerClip{
       self.percent = percent
       setNeedsDisplay()
       return self
    }

    @discardableResult
    public func setPath(_ closure: @escaping (CGRect,UIBezierPath)->Void) -> LayerClip{
       self.mClosure = closure
       invalidatePath()
       return self
    }
    
    public func getPercent() -> CGFloat{
        return percent
    }
    
    public func getGravity() -> Gravity {
        return mGravity
    }

    public func getPath() -> CGPath?{
        return super.path
    }
    public func getIsMainPathActive() -> Bool {
        return mIsMainPathEnabled
    }
      
    
    private func setupMainPath(){
       mMainPath.removeAllPoints()
       if mClosure == nil{
            mMainPath.addRect(super.bounds)
       }else {
            mClosure?(super.bounds,mMainPath)
       }
    }

    //MARK : CUSTOM PROPERTY ANIMATABLE CAANIMATION
    @objc public dynamic var percent :CGFloat = 0

    public override class func needsDisplay(forKey key: String) -> Bool {
        return  key == #keyPath(LayerClip.percent) ? true :
        super.needsDisplay(forKey: key)
    }


    public override func display() {
       super.display()
        displayPercent()
    }

    private func displayPercent(){
        let value = self.presentation()?.percent ?? self.percent
        switch mGravity {
            case .bottom: makeBottom(value)
            case .top : makeTop(value)
            case .left : makeLeft(value)
            case .right : makeRight(value)
        }

    }
        
    private func makeBottom(_ percent: CGFloat){
        var r = super.bounds.height
        r = r <= 0 ? 0 : r
        let dy = r - (percent / 100) * r
        setTranslation(dx: 0, dy: dy)
    }

    private func makeTop(_ percent: CGFloat){
        var range = super.bounds.height
        range = range <= 0 ? 0 : range
        let dy = -(range - (percent / 100) * range)
        setTranslation(dx: 0, dy: dy)
    }

    private func makeRight(_ percent: CGFloat){
        var r = super.bounds.width
       r = r <= 0 ? 0 : r
       let dx = r - (percent / 100) * r
       setTranslation(dx: dx, dy: 0)
    }

    private func makeLeft(_ percent: CGFloat){
        var r = super.bounds.width
       r = r <= 0 ? 0 : r
       let dx = -(r - (percent / 100) * r)
       setTranslation(dx: dx, dy: 0)
    }

    public override init(layer: Any) {
       super.init(layer: layer)
       if let ol = layer as? LayerClip {
           self.percent = ol.percent
       }
    }

    //MARK : BASE


    public required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    public func onBoundsChange(_ bounds: CGRect){
        invalidateFrame(bounds)

    }
    private var mMainPath  = UIBezierPath()
    private func invalidatePath(){
        setupMainPath()
        super.path = mMainPath.cgPath
    }
    private var mMainRect = CGRect()
    private func invalidateFrame(_ bounds:CGRect){
        mMainRect.set(rect: bounds)
        mMainRect.setInset(dx: mInset, dy: mInset)
        super.frame = mMainRect
        super.position.x = bounds.center.x
        super.position.y = bounds.center.y
        invalidatePath()
    }

    private var mTx : CGFloat = 0
    private var mTy : CGFloat = 0
    private func setTranslation(dx:CGFloat,dy:CGFloat) {
     mTx = dx
     mTy = dy
     makeTransform()
    }
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
        let localTransfrom  = CATransform3DMakeTranslation(mTx, mTy, 0)
               super.transform = localTransfrom
    }
    private func disableAnimation(){
      CATransaction.begin()
      CATransaction.setDisableActions(true)
    }
    private func commit(){
      CATransaction.commit()
    }

    public override var frame: CGRect { set{} get { return super.frame } }
    public override var transform: CATransform3D { set{ } get { return super.transform } }
    public override var path: CGPath? { set {} get { return super.path } }
    
}
