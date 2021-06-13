//
//  JJBlurredDrawable.swift
//  jjutils
//
//  Created by Juan J LF on 6/4/21.
//

//not Animatable , slow, example class using CIFilter
import UIKit
public class JJFilteredDrawable: CALayer {


    private let mDrawable = JJDrawable()
    private var mBlurRadius:Float = 0
    
   public override init() {
    super.init()
    }
    
    @discardableResult
   public func setBlur(radius:Float)-> JJFilteredDrawable{
        mBlurRadius = radius
       return self
   }
 
    //MARK: Path set and get
    @discardableResult
   public func setPathScale(sx:CGFloat,sy:CGFloat)-> JJFilteredDrawable{
       mDrawable.setPathScale(sx: sx, sy: sy)
       return self
   }
    @discardableResult
   public func setPathRotation(degrees: CGFloat) -> JJFilteredDrawable{
        mDrawable.setPathRotation(degrees: degrees)
       return self
   }
    @discardableResult
   public func setPathTranslation(dx:CGFloat,dy:CGFloat)-> JJFilteredDrawable {
    mDrawable.setPathTranslation(dx: dx, dy: dy)
       return self
   }
   @discardableResult
   public func setPathTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0, plusY:CGFloat = 0)-> JJFilteredDrawable {
      mDrawable.setPathTranslation(percentX: percentX, percentY: percentY,plusX: plusX,plusY: plusY)
       return self
  }
    
    
    //MARK: set and get
    
    @discardableResult
   public func setShadowOffset(p:CGSize) -> JJFilteredDrawable{
       mDrawable.setShadowOffset(p: p)
       return self
   }
    @discardableResult
   public func setShadowRadius(r:CGFloat) -> JJFilteredDrawable{
    mDrawable.setShadowRadius(r: r)
       return self
   }
    @discardableResult
   public func setShadowOpacity(o:Float) -> JJFilteredDrawable{
        mDrawable.setShadowOpacity(o: o)
       return self
   }
    @discardableResult
   public func setShadowColor(c:CGColor) -> JJFilteredDrawable{
      mDrawable.setShadowColor(c: c)
       return self
   }
    
    //MARK: STROKE SET
    
    @discardableResult
   public func setStrokeWidth(w:CGFloat) -> JJFilteredDrawable{
    mDrawable.setStrokeWidth(w: w)
       return self
   }
    @discardableResult
   public func setStrokeColor(color:CGColor) -> JJFilteredDrawable{
    mDrawable.setStrokeColor(color: color)
       return self
   }
    
    @discardableResult
   public func setStrokeStart(s:CGFloat) -> JJFilteredDrawable{
    mDrawable.setStrokeEnd(e: s)
       return self
   }
    @discardableResult
   public func setStrokeEnd(e:CGFloat) -> JJFilteredDrawable{
    mDrawable.setStrokeEnd(e: e)
       return self
   }
    //MARK: LAYER SET
    
    @discardableResult
    public func setSvgPath(d:String,viewBox:[CGFloat] = [0,0,0,0],align:String = "xMidYMid",aspect:ViewBox.AspectRatio = .meet) -> JJFilteredDrawable{
        mDrawable.setSvgPath(d: d,viewBox: viewBox,align: align,aspect: aspect)
    
       
       return self
   }
    @discardableResult
    public func setShape(s:Drawable.Shape) -> JJFilteredDrawable{
       mDrawable.setShape(s: s)
       return self
   }
    @discardableResult
   public func setRadius(v:CGFloat) -> JJFilteredDrawable{
    mDrawable.setRadius(v: v)
       return self
   }

    @discardableResult
    public func setRadius(topLeft:CGFloat,topRight:CGFloat,bottomLeft:CGFloat,bottomRight:CGFloat) -> JJFilteredDrawable{
        mDrawable.setRadius(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
       return self
   }
    @discardableResult
   public func setFillColor(c:CGColor) -> JJFilteredDrawable{
      mDrawable.setFillColor(c: c)
       return self
   }
    @discardableResult
   public func setBackgroundColor(c:CGColor) -> JJFilteredDrawable{
      mDrawable.setBackgroundColor(c: c)
       return self
   }
    
     @discardableResult
    public func setInset(dx:CGFloat,dy:CGFloat) -> JJFilteredDrawable{
        mDrawable.setInset(dx: dx, dy: dy)
        return self
    }
    
    //MARK: layer set transform
    
     @discardableResult
    public func setScale(sx:CGFloat,sy:CGFloat)-> JJFilteredDrawable{
        mDrawable.setScale(sx: sx, sy: sy)
        return self
    }
     @discardableResult
    public func setRotationZ(degrees: CGFloat) -> JJFilteredDrawable{
        mDrawable.setRotationZ(degrees: degrees)
        return self
    }
    
    @discardableResult
   public func setRotationX(degrees: CGFloat) -> JJFilteredDrawable{
    mDrawable.setRotationX(degrees: degrees)
       return self
   }
    @discardableResult
   public func setRotationY(degrees: CGFloat) -> JJFilteredDrawable{
    mDrawable.setRotationY(degrees: degrees)
       return self
   }
     @discardableResult
    public func setTranslation(dx:CGFloat,dy:CGFloat)-> JJFilteredDrawable {
        mDrawable.setTranslation(dx:dx,dy:dy)
        return self
    }
    @discardableResult
    public func setTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0,plusY:CGFloat = 0)-> JJFilteredDrawable {
        mDrawable.setTranslation(percentX: percentX, percentY: percentY, plusX: plusX, plusY: plusY)
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
    public func setBoundsDynamically(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,percentPos:Bool = false,percentSize:Bool = false)-> JJFilteredDrawable{
        mDrawable.setBoundsDynamically(x: x, y: y, width: width, height: height, percentPos: percentPos, percentSize: percentSize)
      
        return self
    }
    
    
    //MARK: layer methods

    var mImageRenderer = UIGraphicsImageRenderer(size: CGSize(width:0, height: 0))
    public func onBoundsChange(_ frame:CGRect){
        super.frame = frame
        super.position.x = frame.width / 2
        super.position.y = frame.height / 2
        mImageRenderer = UIGraphicsImageRenderer(size: CGSize(width:frame.width, height: frame.height))
       
        mDrawable.onBoundsChange(frame)
        setNeedsDisplay()

    }
    
    public func invalidateSelf(){
        mDrawable.invalidateSelf()
        setNeedsDisplay()
    }
    @objc public dynamic var blur : CGFloat {
        set{
            mBlurRadius = Float(newValue)
        }
        get{
            CGFloat(mBlurRadius)
        }
    }
    @objc public override class func needsDisplay(forKey key: String) -> Bool {
        if(key == #keyPath(JJFilteredDrawable.blur)) { return true }

        return super.needsDisplay(forKey: key)
    }
    private let contextCg = CIContext.init(options: nil)
    public override func display() {
        super.display()
        
        //20ms
        let value = self.presentation()?.blur ?? self.blur
        let img = mImageRenderer.image { (c) in
            mDrawable.render(in: c.cgContext)
        }
    
        if value <= 0 {
            self.contents = img.cgImage!
        }else{
            //200ms to 400ms
            if let result:CIImage = img.blur(Float(value)){
               let cg = contextCg.createCGImage(result, from: result.extent)
                self.contents = cg

           }
        }
      
    
    }
    override init(layer: Any) {
        super.init(layer: layer)
        if let ol = layer as? JJFilteredDrawable { self.blur = ol.blur }
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  

 
}
