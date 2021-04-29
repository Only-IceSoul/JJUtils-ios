//
//  ColorLayer.swift
//  AnimationPractica
//
//  Created by Juan J LF on 10/10/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit
public class Drawable: CAShapeLayer {
    
    public enum Shape {
        case circle,
             svgPath,
             radiusRelativeToWidth,
             radiusRelativeToHeight,
             none
    }
    
  
    //MARK: layer propertys
    private var mRotationX :CGFloat = 0
    private var mRotationY :CGFloat = 0
    private var mRotationZ :CGFloat = 0
    private var mIsRotationX : Bool = false
    private var mIsRotationY : Bool = false
    private var mIsRotationZ : Bool = false
    private var mTranslationX : CGFloat = 0
    private var mTranslationY : CGFloat = 0
 
    private var mTranslationPlusX : CGFloat = 0
    private var mTranslationPlusY : CGFloat = 0
    private var mIsTranslationPercent : Bool = false
    private var mScaleX  : CGFloat = 1
    private var mScaleY  : CGFloat = 1
    private var mInsetX : CGFloat = 0
    private var mInsetY : CGFloat = 0
    private var mBaseRect = CGRect()
    private var mRect = CGRect()
    private var mRadius :[CGFloat] = [0,0,0,0]
    private var mShape = Shape.none
    private var mSvgPath = ""
    private var mSvgAlign = "xMidYMid"
    private var mSvgAspect = ViewBox.AspectRatio.meet
    private var mVbRect = CGRect()
    
    
    //MARK: Path propertys
    private var mPath  = UIBezierPath()
    private var mPathScaleX:CGFloat = 1
    private var mPathScaleY:CGFloat = 1
    private var mPathTranslationX:CGFloat = 0
    private var mPathTranslationY:CGFloat = 0
    private var mPathRotation:CGFloat = 0
    private var mIsPathTranslationPercent = false
    private var mPathTranslationPlusX:CGFloat = 0
    private var mPathTranslationPlusY:CGFloat = 0
    
    public override init() {
        super.init()
        super.fillColor = UIColor.clear.cgColor
        super.shadowOffset = .init(width: 0, height: 0)
        super.lineWidth = 0
        super.strokeColor = UIColor.clear.cgColor
        super.shadowOpacity = 0
        super.shadowRadius = 1
        super.shadowColor = UIColor.black.cgColor
    }
        
    
    //MARK: Path set and get
    @discardableResult
   public func setPathScale(sx:CGFloat,sy:CGFloat, _ animated:Bool = false)-> Drawable{
       mPathScaleX = sx
       mPathScaleY = sy
       return self
   }
    @discardableResult
   public func setPathRotation(degrees: CGFloat) -> Drawable{
       mPathRotation = degrees
       return self
   }
    @discardableResult
   public func setPathTranslation(dx:CGFloat,dy:CGFloat)-> Drawable {
       mPathTranslationX = dx
       mPathTranslationY = dy
       return self
   }
   @discardableResult
   public func setPathTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0, plusY:CGFloat = 0)-> Drawable {
       mPathTranslationX = percentX
       mPathTranslationY = percentY
       mPathTranslationPlusX = plusX
       mPathTranslationPlusY = plusY
       mIsPathTranslationPercent = true
       return self
  }
    
    
    //MARK: set and get
    
    @discardableResult
   public func setShadowOffset(p:CGSize) -> Drawable{
       super.shadowOffset = p
       return self
   }
    @discardableResult
   public func setShadowRadius(r:CGFloat) -> Drawable{
       super.shadowRadius = r
       return self
   }
    @discardableResult
   public func setShadowOpacity(o:Float) -> Drawable{
       super.shadowOpacity = o
       return self
   }
    @discardableResult
   public func setShadowColor(c:CGColor) -> Drawable{
       super.shadowColor = c
       return self
   }
    
    //MARK: STROKE SET
    
    @discardableResult
   public func setStrokeWidth(w:CGFloat) -> Drawable{
       super.lineWidth = w
       return self
   }
    @discardableResult
   public func setStrokeColor(color:CGColor) -> Drawable{
       super.strokeColor = color
       return self
   }
    
    //MARK: LAYER SET
    
    @discardableResult
    public func setSvgPath(d:String,viewBox:[CGFloat] = [0,0,0,0],align:String = "xMidYMid",aspect:ViewBox.AspectRatio = .meet) -> Drawable{
        mSvgPath = d
        mSvgAlign = align
        mSvgAspect = aspect
        
        mVbRect.origin.x = viewBox[0]
        mVbRect.origin.y = viewBox[1]
        mVbRect.size.width = viewBox[2]
        mVbRect.size.height = viewBox[3]
    
       
       return self
   }
    @discardableResult
   public func setShape(s:Shape) -> Drawable{
       mShape = s
       return self
   }
    @discardableResult
   public func setRadius(v:CGFloat) -> Drawable{
       mRadius = [v,v,v,v]
       return self
   }

    @discardableResult
    public func setRadius(topLeft:CGFloat,topRight:CGFloat,bottomLeft:CGFloat,bottomRight:CGFloat) -> Drawable{
       mRadius = [topLeft,topRight,bottomLeft,bottomRight]
       return self
   }
    @discardableResult
   public func setFillColor(c:CGColor) -> Drawable{
       super.fillColor = c
       return self
   }
   
    
     @discardableResult
    public func setInset(dx:CGFloat,dy:CGFloat) -> Drawable{
        mInsetY = dy.normalizedNotNegative()
        mInsetX = dx.normalizedNotNegative()
        return self
    }
    
    //MARK: layer set transform
    
     @discardableResult
    public func setScale(sx:CGFloat,sy:CGFloat)-> Drawable{
        mScaleX = sx
        mScaleY = sy
        return self
    }
     @discardableResult
    public func setRotationZ(degrees: CGFloat) -> Drawable{
        mRotationZ = degrees
        mIsRotationZ = true
        return self
    }
    
    @discardableResult
   public func setRotationX(degrees: CGFloat) -> Drawable{
       mRotationX = degrees
       mIsRotationX = true
       return self
   }
    @discardableResult
   public func setRotationY(degrees: CGFloat) -> Drawable{
       mRotationY = degrees
       mIsRotationY = true
       return self
   }
     @discardableResult
    public func setTranslation(dx:CGFloat,dy:CGFloat)-> Drawable {
        mTranslationX = dx
        mTranslationY = dy
        return self
    }
    @discardableResult
    public func setTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0,plusY:CGFloat = 0)-> Drawable {
        mTranslationX = percentX
        mTranslationY = percentY
        mTranslationPlusX = plusX
        mTranslationPlusY = plusY
        mIsTranslationPercent = true
        return self
   }
 
    
    private var mFirstBounds = CGRect()
    private var mBoundsX:CGFloat = 0
    private var mBoundsY:CGFloat = 0
    private var mBoundsWidth:CGFloat = 0
    private var mBoundsHeight:CGFloat = 0
    private var mIsBoundsDynamically = false
    private var mIsBoundsPercentPos = false
    private var mIsBoundsPercentSize = false
    /**
     
      Put the position and size of the layer where it will draw  relative in percentage-absolute to the bounds it received, naturally it always receives the bounds of the parent.
      
      Percentage values  0 = 0% - 1 = 100% 
      
      - Parameters:
          - x :  x origin
          - y :  y origin
          - width : a width value
          - height : a height value
          - percentPos : if origin is a percentage value, default false
          - percentSize: if size is a percentage value, default false
      
      */
    @discardableResult
    public func setBoundsDynamically(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,percentPos:Bool = false,percentSize:Bool = false)-> Drawable{
        mIsBoundsDynamically = true
        mIsBoundsPercentPos = percentPos
        mIsBoundsPercentSize = percentSize
        mBoundsX = x
        mBoundsY = y
        mBoundsWidth = width.normalizedNotNegative()
        mBoundsHeight = height.normalizedNotNegative()
        return self
    }
    
    
    //MARK: layer methods
    
    public func onBoundsChange(_ frame: CGRect){
        mFirstBounds.set(rect: frame)
        
        if(mIsBoundsPercentPos){
            mBoundsX *= frame.width
            mBoundsY *= frame.height
            
        }
        if(mIsBoundsPercentSize){
            mBoundsWidth *= frame.width
            mBoundsHeight *= frame.height
        }
        if(mIsBoundsDynamically){
            
            mBaseRect.origin.x = mBoundsX
            mBaseRect.origin.y = mBoundsY
            mBaseRect.size.width = mBoundsWidth
            mBaseRect.size.height = mBoundsHeight
        }else{
            mBaseRect.set(rect: frame)
        }
        
          
          draw(frame)
    }
    
    private func draw(_ bounds:CGRect){
        if(mFirstBounds.width > 0 && mFirstBounds.height > 0){
            setupRect()
            setupPath()
            
            makeTransform()
        }
     
        
    }
    
    
    private func setupRect(){
        mRect.set(rect: mBaseRect)
        mRect.setInset(dx: mInsetX, dy: mInsetY)
        let strokeInset = super.lineWidth / 2
        mRect.setInset(dx: strokeInset, dy: strokeInset)
        super.frame = mRect
        super.position.x = mRect.width / 2
        super.position.y = mRect.height / 2
    }
    
    private func setupPath(){
        mPath.removeAllPoints()
        switch mShape {
        case .circle:
            let r = min(mRect.width, mRect.height) / 2
            mRadius = [r,r,r,r]
            //cw
            mPath.addRoundRect(mRect, radius: mRadius)
            break
        case .radiusRelativeToHeight,.radiusRelativeToWidth :
            let tl = mRadius[0].normalized()
            let tr = mRadius[1].normalized()
            let bl = mRadius[2].normalized()
            let br = mRadius[3].normalized()
            var size = mShape == .radiusRelativeToWidth ? mRect.width : 0
            size = mShape == .radiusRelativeToHeight ? mRect.height : size
            mRadius[0] = tl * size
            mRadius[1] = tr * size
            mRadius[2] = bl * size
            mRadius[3] = br * size
            //cw
            mPath.addRoundRect(mRect, radius: mRadius)
            break
   
        case .svgPath:
            mPath = PathParser.parse(d: mSvgPath)
            if mVbRect.width > 0 && mVbRect.height > 0 {
                let trans = ViewBox.transform(vbRect: mVbRect, eRect: mRect, align: mSvgAlign, meetOrSlice: mSvgAspect)
              
                mPath.apply(trans)
            }
           
            
            
        default:
            mPath.addRoundRect(mRect, radius: mRadius)
        }
        
        //path transform
        if(mIsPathTranslationPercent){
            mPathTranslationX = (mPathTranslationX * mBaseRect.width) + mPathTranslationPlusX
            mPathTranslationY = (mPathTranslationY * mBaseRect.height) + mPathTranslationPlusY
        }
        
        //first translate for rotate and scale from center
        let t = CGAffineTransform.identity
            .translatedBy(x: mPathTranslationX, y: mPathTranslationY)
            
            .translatedBy(x: mPath.bounds.center.x, y: mPath.bounds.center.y)
            .rotated(by: mPathRotation.toRadians())
            .scaledBy(x: mPathScaleX, y: mPathScaleY)
            .translatedBy(x: -mPath.bounds.center.x , y: -mPath.bounds.center.y)
          
         
            
        mPath.apply(t)
        
        super.path = mPath.cgPath
        super.shadowPath = mPath.cgPath
    }
    
  

   
    
  
    
    public func invalidateSelf(){
        draw(mBaseRect)
    }
    
    
 
    private func makeTransform(_ animated:Bool = false){
        if(mIsTranslationPercent){
            mTranslationX = (mTranslationX * mFirstBounds.width) + mTranslationPlusX
            mTranslationY = (mTranslationY * mFirstBounds.height) + mTranslationPlusY
        }
        if(animated && duration > 0){
            applyTransform()
        }else {
            disableAnimation()
            applyTransform()
            commit()
        }
    }
    private func applyTransform(){
        
        var perspective = CATransform3DIdentity

   
        perspective.m34 = 1 / -400;
       
        if(mIsRotationX){
            perspective = CATransform3DRotate(perspective, -mRotationX.toRadians(), 1, 0, 0)
        }
        if(mIsRotationY){
            perspective = CATransform3DRotate(perspective, -mRotationY.toRadians(), 0, 1, 0)
        }
        
 
       
        var normal = CATransform3DIdentity;
        
        if(mIsRotationZ){
            normal = CATransform3DRotate(normal, mRotationZ.toRadians(), 0, 0, 1)
        }
        //first translation for for scale from center
        normal = CATransform3DTranslate(normal, mTranslationX, mTranslationY, 0)
        normal = CATransform3DScale(normal, mScaleX, mScaleX, 1)
      
        
        self.transform = CATransform3DConcat(perspective, normal)
    }
    private func disableAnimation(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
    }
    
    private func commit(){
        CATransaction.commit()
    }
    
    
    
   
    public override init(layer: Any) {
        super.init(layer: layer)

    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    //MARK : public override
    
       public override var backgroundColor :CGColor? {
           set { print("Drawable - Background is not supported") }
           get { return super.backgroundColor }
       }
      
}
