//
//  JJDrawable.swift
//  testany
//
//  Created by Juan J LF on 4/28/21.
//


//With background
import UIKit
public class JJDrawable: CAShapeLayer {
    
    
    
    private let mBg = Drawable()
    private let mDrawable = Drawable()
    public override init() {
        super.init()
        addSublayer(mBg)
        addSublayer(mDrawable)
  
    }
        

    //MARK: Path set and get
    @discardableResult
   public func setPathScale(sx:CGFloat,sy:CGFloat)-> JJDrawable{
       mDrawable.setPathScale(sx: sx, sy: sy)
       return self
   }
    @discardableResult
   public func setPathRotation(degrees: CGFloat) -> JJDrawable{
        mDrawable.setPathRotation(degrees: degrees)
       return self
   }
    @discardableResult
   public func setPathTranslation(dx:CGFloat,dy:CGFloat)-> JJDrawable {
    mDrawable.setPathTranslation(dx: dx, dy: dy)
       return self
   }
   @discardableResult
   public func setPathTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0, plusY:CGFloat = 0)-> JJDrawable {
      mDrawable.setPathTranslation(percentX: percentX, percentY: percentY,plusX: plusX,plusY: plusY)
       return self
  }
    
    
    //MARK: set and get
    
    @discardableResult
   public func setShadowOffset(p:CGSize) -> JJDrawable{
       mDrawable.setShadowOffset(p: p) 
       return self
   }
    @discardableResult
   public func setShadowRadius(r:CGFloat) -> JJDrawable{
    mDrawable.setShadowRadius(r: r)
       return self
   }
    @discardableResult
   public func setShadowOpacity(o:Float) -> JJDrawable{
        mDrawable.setShadowOpacity(o: o)
       return self
   }
    @discardableResult
   public func setShadowColor(c:CGColor) -> JJDrawable{
      mDrawable.setShadowColor(c: c)
       return self
   }
    
    //MARK: STROKE SET
    
    @discardableResult
   public func setStrokeWidth(w:CGFloat) -> JJDrawable{
    mDrawable.setStrokeWidth(w: w)
       return self
   }
    @discardableResult
   public func setStrokeColor(color:CGColor) -> JJDrawable{
    mDrawable.setStrokeColor(color: color)
       return self
   }
    
    @discardableResult
   public func setStrokeStart(s:CGFloat) -> JJDrawable{
    mDrawable.strokeStart = s
       return self
   }
    @discardableResult
   public func setStrokeEnd(e:CGFloat) -> JJDrawable{
    mDrawable.strokeEnd = e
       return self
   }
    //MARK: LAYER SET
    
    @discardableResult
    public func setSvgPath(d:String,viewBox:[CGFloat] = [0,0,0,0],align:String = "xMidYMid",aspect:ViewBox.AspectRatio = .meet) -> JJDrawable{
        mDrawable.setSvgPath(d: d,viewBox: viewBox,align: align,aspect: aspect)
    
       
       return self
   }
    @discardableResult
    public func setShape(s:Drawable.Shape) -> JJDrawable{
       mDrawable.setShape(s: s)
       return self
   }
    @discardableResult
   public func setRadius(v:CGFloat) -> JJDrawable{
    mDrawable.setRadius(v: v)
       return self
   }

    @discardableResult
    public func setRadius(topLeft:CGFloat,topRight:CGFloat,bottomLeft:CGFloat,bottomRight:CGFloat) -> JJDrawable{
        mDrawable.setRadius(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
       return self
   }
    @discardableResult
   public func setFillColor(c:CGColor) -> JJDrawable{
      mDrawable.setFillColor(c: c)
       return self
   }
    @discardableResult
   public func setBackgroundColor(c:CGColor) -> JJDrawable{
      mBg.setFillColor(c: c)
       return self
   }
    
     @discardableResult
    public func setInset(dx:CGFloat,dy:CGFloat) -> JJDrawable{
        mDrawable.setInset(dx: dx, dy: dy)
        return self
    }
    
    //MARK: layer set transform
    
     @discardableResult
    public func setScale(sx:CGFloat,sy:CGFloat)-> JJDrawable{
        mDrawable.setScale(sx: sx, sy: sy)
        mBg.setScale(sx: sx, sy: sy)
        return self
    }
     @discardableResult
    public func setRotationZ(degrees: CGFloat) -> JJDrawable{
        mDrawable.setRotationZ(degrees: degrees)
        mBg.setRotationZ(degrees: degrees)
        return self
    }
    
    @discardableResult
   public func setRotationX(degrees: CGFloat) -> JJDrawable{
    mDrawable.setRotationX(degrees: degrees)
    mBg.setRotationX(degrees: degrees)
       return self
   }
    @discardableResult
   public func setRotationY(degrees: CGFloat) -> JJDrawable{
    mDrawable.setRotationY(degrees: degrees)
    mBg.setRotationY(degrees: degrees)
       return self
   }
     @discardableResult
    public func setTranslation(dx:CGFloat,dy:CGFloat)-> JJDrawable {
        mDrawable.setTranslation(dx:dx,dy:dy)
        mBg.setTranslation(dx:dx,dy:dy)
        return self
    }
    @discardableResult
    public func setTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0,plusY:CGFloat = 0)-> JJDrawable {
        mDrawable.setTranslation(percentX: percentX, percentY: percentY, plusX: plusX, plusY: plusY)
        mBg.setTranslation(percentX: percentX, percentY: percentY, plusX: plusX, plusY: plusY)
        return self
   }
 
    
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
    public func setBoundsDynamically(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,percentPos:Bool = false,percentSize:Bool = false)-> JJDrawable{
        mDrawable.setBoundsDynamically(x: x, y: y, width: width, height: height, percentPos: percentPos, percentSize: percentSize)
        mBg.setBoundsDynamically(x: x, y: y, width: width, height: height, percentPos: percentPos, percentSize: percentSize)
      
        return self
    }
    
    
    //MARK: layer methods
    
    public func onBoundsChange(_ frame: CGRect){
        super.frame = frame
        super.position.x = frame.width / 2
        super.position.y = frame.height / 2
        mDrawable.onBoundsChange(frame)
        mBg.onBoundsChange(frame)
        
    }
    
    public func invalidateSelf(){
        mDrawable.invalidateSelf()
        mBg.invalidateSelf()
        
        
        
    }
    
    public func getLayer()-> Drawable{
        return mDrawable
    }
    
    public func getBackgroundLayer()->Drawable{
        return mBg
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)

    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

 
}
