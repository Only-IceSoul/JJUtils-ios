//
//  BlurredDrawable.swift
//  jjutils
//
//  Created by Juan J LF on 6/4/21.
//


import UIKit
public class JJFilteredDrawableView: UIImageView {
    

    private let mDrawable = JJDrawable()
    private var mBlurRadius:Float = 0
    
   public init() {
        super.init(frame: .zero)
    }
    
    @discardableResult
   public func setBlur(radius:Float)-> JJFilteredDrawableView{
        mBlurRadius = radius
       return self
   }
 
    //MARK: Path set and get
    @discardableResult
   public func setPathScale(sx:CGFloat,sy:CGFloat)-> JJFilteredDrawableView{
       mDrawable.setPathScale(sx: sx, sy: sy)
       return self
   }
    @discardableResult
   public func setPathRotation(degrees: CGFloat) -> JJFilteredDrawableView{
        mDrawable.setPathRotation(degrees: degrees)
       return self
   }
    @discardableResult
   public func setPathTranslation(dx:CGFloat,dy:CGFloat)-> JJFilteredDrawableView {
    mDrawable.setPathTranslation(dx: dx, dy: dy)
       return self
   }
   @discardableResult
   public func setPathTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0, plusY:CGFloat = 0)-> JJFilteredDrawableView {
      mDrawable.setPathTranslation(percentX: percentX, percentY: percentY,plusX: plusX,plusY: plusY)
       return self
  }
    
    
    //MARK: set and get
    
    @discardableResult
   public func setShadowOffset(p:CGSize) -> JJFilteredDrawableView{
       mDrawable.setShadowOffset(p: p)
       return self
   }
    @discardableResult
   public func setShadowRadius(r:CGFloat) -> JJFilteredDrawableView{
    mDrawable.setShadowRadius(r: r)
       return self
   }
    @discardableResult
   public func setShadowOpacity(o:Float) -> JJFilteredDrawableView{
        mDrawable.setShadowOpacity(o: o)
       return self
   }
    @discardableResult
   public func setShadowColor(c:CGColor) -> JJFilteredDrawableView{
      mDrawable.setShadowColor(c: c)
       return self
   }
    
    //MARK: STROKE SET
    
    @discardableResult
   public func setStrokeWidth(w:CGFloat) -> JJFilteredDrawableView{
    mDrawable.setStrokeWidth(w: w)
       return self
   }
    @discardableResult
   public func setStrokeColor(color:CGColor) -> JJFilteredDrawableView{
    mDrawable.setStrokeColor(color: color)
       return self
   }
    
    @discardableResult
   public func setStrokeStart(s:CGFloat) -> JJFilteredDrawableView{
    mDrawable.strokeStart = s
       return self
   }
    @discardableResult
   public func setStrokeEnd(e:CGFloat) -> JJFilteredDrawableView{
    mDrawable.strokeEnd = e
       return self
   }
    //MARK: LAYER SET
    
    @discardableResult
    public func setSvgPath(d:String,viewBox:[CGFloat] = [0,0,0,0],align:String = "xMidYMid",aspect:ViewBox.AspectRatio = .meet) -> JJFilteredDrawableView{
        mDrawable.setSvgPath(d: d,viewBox: viewBox,align: align,aspect: aspect)
    
       
       return self
   }
    @discardableResult
    public func setShape(s:Drawable.Shape) -> JJFilteredDrawableView{
       mDrawable.setShape(s: s)
       return self
   }
    @discardableResult
   public func setRadius(v:CGFloat) -> JJFilteredDrawableView{
    mDrawable.setRadius(v: v)
       return self
   }

    @discardableResult
    public func setRadius(topLeft:CGFloat,topRight:CGFloat,bottomLeft:CGFloat,bottomRight:CGFloat) -> JJFilteredDrawableView{
        mDrawable.setRadius(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
       return self
   }
    @discardableResult
   public func setFillColor(c:CGColor) -> JJFilteredDrawableView{
      mDrawable.setFillColor(c: c)
       return self
   }
    @discardableResult
   public func setBackgroundColor(c:CGColor) -> JJFilteredDrawableView{
      mDrawable.setBackgroundColor(c: c)
       return self
   }
    
     @discardableResult
    public func setInset(dx:CGFloat,dy:CGFloat) -> JJFilteredDrawableView{
        mDrawable.setInset(dx: dx, dy: dy)
        return self
    }
    
    //MARK: layer set transform
    
     @discardableResult
    public func setScale(sx:CGFloat,sy:CGFloat)-> JJFilteredDrawableView{
        mDrawable.setScale(sx: sx, sy: sy)
        return self
    }
     @discardableResult
    public func setRotationZ(degrees: CGFloat) -> JJFilteredDrawableView{
        mDrawable.setRotationZ(degrees: degrees)
        return self
    }
    
    @discardableResult
   public func setRotationX(degrees: CGFloat) -> JJFilteredDrawableView{
    mDrawable.setRotationX(degrees: degrees)
       return self
   }
    @discardableResult
   public func setRotationY(degrees: CGFloat) -> JJFilteredDrawableView{
    mDrawable.setRotationY(degrees: degrees)
       return self
   }
     @discardableResult
    public func setTranslation(dx:CGFloat,dy:CGFloat)-> JJFilteredDrawableView {
        mDrawable.setTranslation(dx:dx,dy:dy)
        return self
    }
    @discardableResult
    public func setTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0,plusY:CGFloat = 0)-> JJFilteredDrawableView {
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
    public func setBoundsDynamically(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,percentPos:Bool = false,percentSize:Bool = false)-> JJFilteredDrawableView{
        mDrawable.setBoundsDynamically(x: x, y: y, width: width, height: height, percentPos: percentPos, percentSize: percentSize)
      
        return self
    }
    
    
    //MARK: layer methods
    
    var mImageRenderer = UIGraphicsImageRenderer(size: CGSize(width:0, height: 0))
    public override var bounds: CGRect {
        didSet{
            mDrawable.onBoundsChange(bounds)
            mImageRenderer = UIGraphicsImageRenderer(size: CGSize(width:frame.width, height: frame.height))
            
            invalidateSelf()
        }
    }
    
    public func invalidateSelf(){
        mDrawable.invalidateSelf()
        drawImage()
    }
    
    public  func drawImage() {
        let img = mImageRenderer.image { (c) in
            mDrawable.render(in: c.cgContext)
        }
       
        if let result = img.blur(mBlurRadius){
            image = result
            
        }
    }
    
    
    
    public func getLayer()-> JJDrawable{
        return mDrawable
    }
    

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

 
}
