//
//  SkiaDrawable.swift
//  Pods
//
//  Created by Juan J LF on 6/1/21.

import Foundation
import UIKit
import SkiaKit


public class SkiaDrawable: CALayer {

    public enum Shape {
        case circle,
             svgPath,
             radiusRelativeToWidth,
             radiusRelativeToHeight,
             none
    }
    
    

    private var mPaint = Paint()
    private var mPaintBg = Paint()
    private var mPaintStroke = Paint()
    
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
    private var mInsetX : Float = 0
    private var mInsetY : Float = 0
    private var mBaseRect = RectF()
    private var mRect = RectF()
    private var mRadius :[Float] = [0,0,0,0,0,0,0,0]
    private var mShape = Shape.none
    private var mSvgPath = ""
    private var mSvgAlign = "xMidYMid"
    private var mSvgAspect = ViewBox.AspectRatio.meet
    private var mVbRect = RectF()
    private var mVbMatrix = Matrix()
    private var mPathMeasure = PathMeasure()


    //MARK: STROKE PROPS
    
    private var mStrokeStart : Float = 0
    private var mStrokeEnd : Float = 1
    
    //MARK: SHADOW PROPS
    
    private var mShadowOffsetX : Float = 0
    private var mShadowOffsetY : Float = 0
    private var mShadowRadius : Float = 2
    private var mShadowOpacity : Float = 0
    private var mShadowColor = Color.BLACK
    
    //MARK: Path PROPS
    private var mPath  = Path()
    private var mPathStroke = Path()
    private var mPathScaleX:Float = 1
    private var mPathScaleY:Float = 1
    private var mPathTranslationX:Float = 0
    private var mPathTranslationY:Float = 0
    private var mPathRotation:Float = 0
    private var mIsPathTranslationPercent = false
    private var mPathTranslationPlusX:Float = 0
    private var mPathTranslationPlusY:Float = 0
    private var mPathMatrix = Matrix()
    private var mPathBounds = RectF()
    
    //MARK: BLUR PROPS
    private var mBlurRadius : Float = 0
    private var mBorderBlurRadius : Float = 0
    private var mBgBlurRadius : Float = 0
    
    
    public override init() {
        super.init()
        
        mPaint.isAntialias = true
        mPaint.style = Paint.Style.fill
        mPaint.color = Color.TRANSPARENT
        mPaint.strokeWidth = 0
        
        mPaintBg.style = Paint.Style.fill
        mPaintBg.color = Color.TRANSPARENT
        mPaintBg.isAntialias = true
        
        mPaintStroke.style = Paint.Style.stroke
        mPaintStroke.strokeWidth = 0
        mPaintStroke.color = Color.BLACK
        mPaintStroke.isAntialias = true
    }

    
    @discardableResult
    public func setBlur(radius:Float)-> SkiaDrawable{
        mBlurRadius = radius
        mBgBlurRadius = radius
        mBorderBlurRadius = radius
        
        return self
   }

    @discardableResult
    public func setBackgroundBlur(radius:Float)-> SkiaDrawable{
        mBgBlurRadius = radius
        return self
   }

    @discardableResult
    public func setFillBlur(radius:Float)-> SkiaDrawable{
        mBlurRadius = radius
        return self
   }
    
    
    @discardableResult
    public func setBorderBlur(radius:Float)-> SkiaDrawable{
        mBorderBlurRadius = radius
        return self
   }
    
    //MARK: Path set and get
    @discardableResult
   public func setPathScale(sx:Float,sy:Float)-> SkiaDrawable{
       mPathScaleX = sx
       mPathScaleY = sy
       return self
   }
    @discardableResult
   public func setPathRotation(degrees: Float) -> SkiaDrawable{
       mPathRotation = degrees
       return self
   }
    @discardableResult
   public func setPathTranslation(dx:Float,dy:Float)-> SkiaDrawable {
      mIsPathTranslationPercent = false
       mPathTranslationX = dx
       mPathTranslationY = dy
       return self
   }
   @discardableResult
   public func setPathTranslation(percentX:Float,percentY:Float, plusX:Float = 0, plusY:Float = 0)-> SkiaDrawable {
       mPathTranslationX = percentX
       mPathTranslationY = percentY
       mPathTranslationPlusX = plusX
       mPathTranslationPlusY = plusY
       mIsPathTranslationPercent = true
       return self
  }


    //MARK: SHADOW set

    @discardableResult
    public func setShadowOffset(x:Float,y:Float) -> SkiaDrawable{
        mShadowOffsetX = x
        mShadowOffsetY = y
        return self
   }
    @discardableResult
   public func setShadowRadius(r:Float) -> SkiaDrawable{
       mShadowRadius = r
       return self
   }
    @discardableResult
   public func setShadowOpacity(o:Float) -> SkiaDrawable{
       mShadowOpacity = o
       return self
   }
    @discardableResult
   public func setShadowColor(c:UInt32) -> SkiaDrawable{
       mShadowColor = c
       return self
   }

    //MARK: STROKE SET

    @discardableResult
   public func setStrokeWidth(w:Float) -> SkiaDrawable{
        mPaint.strokeWidth = w
        mPaintStroke.strokeWidth = w
        return self
   }
    @discardableResult
   public func setStrokeColor(color:UInt32) -> SkiaDrawable{
        mPaintStroke.color = color
        return self
   }
    @discardableResult
   public func setStrokeStart(s:Float) -> SkiaDrawable{
        mStrokeStart = s
        return self
   }
    @discardableResult
   public func setStrokeEnd(e:Float) -> SkiaDrawable{
        mStrokeEnd = e
        return self
   }

    //MARK: LAYER SET

    @discardableResult
    public func setSvgPath(d:String,viewBox:[Float] = [0,0,0,0],align:String = "xMidYMid",aspect:ViewBox.AspectRatio = .meet) -> SkiaDrawable{
        mSvgPath = d
        mSvgAlign = align
        mSvgAspect = aspect
//        let scale = Float(UIScreen.main.scale)
        mVbRect.set(left: viewBox[0] ,
                    top: viewBox[1] ,
                    right: (viewBox[0] + viewBox[2]) ,
                    bottom: (viewBox[1] + viewBox[3]) )
        

       return self
   }
    @discardableResult
   public func setShape(s:Shape) -> SkiaDrawable{
       mShape = s
       return self
   }
    @discardableResult
   public func setRadius(v:Float) -> SkiaDrawable{
       mRadius = [v,v,v,v,v,v,v,v]
       return self
   }

    @discardableResult
    public func setRadius(topLeft:Float,topRight:Float,bottomLeft:Float,bottomRight:Float) -> SkiaDrawable{
       mRadius = [topLeft,topLeft,topRight,topRight,bottomRight,bottomRight,bottomLeft,bottomLeft]
       return self
   }
    @discardableResult
   public func setFillColor(c:UInt32) -> SkiaDrawable{
        mPaint.color = c
       return self
   }
    @discardableResult
   public func setBackgroundColor(c:UInt32) -> SkiaDrawable{
        mPaintBg.color = c
       return self
   }

     @discardableResult
    public func setInset(dx:Float,dy:Float) -> SkiaDrawable{
        mInsetY = dy.clampNotNegative()
        mInsetX = dx.clampNotNegative()
        return self
    }

    //MARK: layer set transform

     @discardableResult
    public func setScale(sx:CGFloat,sy:CGFloat)-> SkiaDrawable{
        mScaleX = sx
        mScaleY = sy
        return self
    }
     @discardableResult
    public func setRotationZ(degrees: CGFloat) -> SkiaDrawable{
        mRotationZ = degrees
        mIsRotationZ = true
        return self
    }

    @discardableResult
   public func setRotationX(degrees: CGFloat) -> SkiaDrawable{
       mRotationX = degrees
       mIsRotationX = true
       return self
   }
    @discardableResult
   public func setRotationY(degrees: CGFloat) -> SkiaDrawable{
       mRotationY = degrees
       mIsRotationY = true
       return self
   }
     @discardableResult
    public func setTranslation(dx:CGFloat,dy:CGFloat)-> SkiaDrawable {
        mIsTranslationPercent = false
        mTranslationX = dx
        mTranslationY = dy
        return self
    }
    @discardableResult
    public func setTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0,plusY:CGFloat = 0)-> SkiaDrawable {
        mTranslationX = percentX
        mTranslationY = percentY
        mTranslationPlusX = plusX
        mTranslationPlusY = plusY
        mIsTranslationPercent = true
        return self
   }


    private var mBoundsX:Float = 0
    private var mBoundsY:Float = 0
    private var mBoundsWidth:Float = 0
    private var mBoundsHeight:Float = 0
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
    public func setBoundsDynamically(x:Float,y:Float,width:Float,height:Float,percentPos:Bool = false,percentSize:Bool = false)-> SkiaDrawable{
        mIsBoundsDynamically = true
        mIsBoundsPercentPos = percentPos
        mIsBoundsPercentSize = percentSize
        mBoundsX = x
        mBoundsY = y
        mBoundsWidth = width.clampNotNegative()
        mBoundsHeight = height.clampNotNegative()
        return self
    }


    //MARK: layer methods
    private var mInfo : ImageInfo?
    private var mBitmap : Bitmap?
    private var mCanvas: Canvas?
    private var mBlurRect = RectF()
    public func onBoundsChange(_ frame: CGRect){


        if(mIsBoundsPercentPos){
            mBoundsX *= Float(frame.width)
            mBoundsY *= Float(frame.height)

        }
        if(mIsBoundsPercentSize){
            mBoundsWidth *= Float(frame.width)
            mBoundsHeight *= Float(frame.height)
        }
        if(mIsBoundsDynamically){
            mBaseRect.set(left: mBoundsX, top: mBoundsY, right: mBoundsX+mBoundsWidth, bottom: mBoundsY+mBoundsHeight)
        }else{
            mBaseRect.set(left: Float(frame.origin.x), top: Float(frame.origin.y), right: Float(frame.origin.x+frame.size.width), bottom: Float(frame.origin.y+frame.size.height))
        }
        
        super.frame = frame
        super.position.x = frame.width / 2
        super.position.y = frame.height / 2
        
        mInfo = ImageInfo(width: Int32 (frame.width), height: Int32 (frame.height), colorType: .bgra8888, alphaType: .premul)
        mBitmap = try? Bitmap(mInfo!)
    
        mCanvas = mBitmap != nil ? Canvas(mBitmap!) : nil
        invalidateSelf()
    }

    private let mBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue).union(.byteOrder32Little)
    private let mColorSpace = CGColorSpaceCreateDeviceRGB()
    public override func display() {
        super.display()
       

    }

    private func drawLayer(){
        if(frame.width > 0 && frame.height > 0){
           
        
            if mCanvas != nil && mBitmap != nil {
                setupRect()
                setupPath()
                setupPathTransform()

                mCanvas!.clear()
                //bg
                if mPaintBg.color != Color.TRANSPARENT{
                    mBlurRect.set(src: mBaseRect)
                    mPaintBg.maskFilter = mBgBlurRadius > 0 ? BlurMaskFilter(radius: mBgBlurRadius, style: .normal) : nil
                    if mBgBlurRadius > 0{
                        mBlurRect.inset(dx: mBgBlurRadius, dy: mBgBlurRadius)
                    }
                    mCanvas!.drawRect(mBlurRect, mPaintBg)
                }
                
                //fill
                if mPaint.color != Color.TRANSPARENT || mShadowOpacity > 0{
                    if mShadowOpacity > 0 {
                        mPaint.imageFilter = DropShadowImageFilter(radius: mShadowRadius, offsetX: mShadowOffsetX, offsetY: mShadowOffsetY, color: mShadowColor, shadowMode: .DRAW_SHADOW_AND_FOREGROUND)
                    }else{
                        mPaint.imageFilter = nil
                    }
                    mPaint.maskFilter = mBlurRadius > 0 ? BlurMaskFilter(radius: mBlurRadius, style: .normal) : nil
                    mCanvas!.drawPath(mPath, mPaint)
                }
                
                //stroke
                if mPaintStroke.color != Color.TRANSPARENT && mPaintStroke.strokeWidth > 0 && mStrokeStart < mStrokeEnd {
                    
                    mPaintStroke.maskFilter = mBorderBlurRadius > 0 ? BlurMaskFilter(radius: mBorderBlurRadius, style: .normal) : nil
                    
                    if mStrokeStart != 0 || mStrokeEnd != 1 {
                        mPathStroke.reset()
                        mPathMeasure.setPath(mPath, forceClosed: false)
                        let _ = mPathMeasure.getSegment(startD: mPathMeasure.getLength() * mStrokeStart, stopD: mPathMeasure.getLength() * mStrokeEnd, dst: mPathStroke, startWithMoveTo: true)
                        mPathStroke.rlineTo(0, 0)
                        mCanvas!.drawPath(mPathStroke, mPaintStroke)
                    }else{
                        mCanvas!.drawPath(mPath, mPaintStroke)
                    }
                   
                }
                
                
                let pixels = mBitmap!.getPixels()

                guard let buffer = pixels.buffer else { return }
                guard let dataProvider = CGDataProvider(dataInfo: nil, data: buffer, size: mInfo!.bytesSize, releaseData: {ctx, ptr, size in }) else {return}
            
                if let image = CGImage(width: Int(mInfo!.width), height: Int(mInfo!.height), bitsPerComponent: 8, bitsPerPixel: Int(mInfo!.bytesPerPixel*8), bytesPerRow: mInfo!.rowBytes, space: mColorSpace, bitmapInfo: mBitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent) {

                    self.contents = image

                }

                makeTransform()
  
             }
            
        }
    }
    
    private func setupRect(){
        mRect.set(src: mBaseRect)
        mRect.inset(dx: mInsetX, dy: mInsetY)
        let strokeInset = mPaint.strokeWidth / 2
        mRect.inset(dx: strokeInset, dy: strokeInset)
    }

    private func setupPath(){
        mPath.reset()
        switch mShape {
        case .circle:
            let r = min(mRect.width, mRect.height) / 2
            mRadius = [r,r,r,r,r,r,r,r]
            //cw
            try! mPath.addRoundRect(mRect, radii: mRadius)
            break
        case .radiusRelativeToHeight,.radiusRelativeToWidth :
            let tl = mRadius[0].clamp()
            let tr = mRadius[1].clamp()
            let bl = mRadius[2].clamp()
            let br = mRadius[3].clamp()
            let size = mShape == .radiusRelativeToWidth ? mRect.width : mRect.height
         
            mRadius[0] = tl * size
            mRadius[1] = tl * size
            mRadius[2] = tr * size
            mRadius[3] = tr * size
            mRadius[4] = br * size
            mRadius[5] = br * size
            mRadius[6] = bl * size
            mRadius[7] = bl * size
            //cw
            try! mPath.addRoundRect(mRect, radii: mRadius)
            break

        case .svgPath:
            
//            let p = SVGPathParser(pathString: mSvgPath).getPath()
            if let p = Path.parseSvgPathData(svgPath: mSvgPath){
              
            mPath.set(p)
        
                if mVbRect.width > 0 && mVbRect.height > 0 {
                 
                  ViewBox.skiaTransform(vbRect: mVbRect, eRect: mRect, align: mSvgAlign, meetOrSlice: mSvgAspect, dst: &mVbMatrix)

                    mPath.transform(matrix: mVbMatrix)
                    
                }

            }
            break
        default:
            try! mPath.addRoundRect(mRect, radii: mRadius)
        }

     
    }


    private func setupPathTransform(){
        //path transform
        if(mIsPathTranslationPercent){
            mPathTranslationX = (mPathTranslationX * mBaseRect.width) + mPathTranslationPlusX
            mPathTranslationY = (mPathTranslationY * mBaseRect.height) + mPathTranslationPlusY
        }

        mPathBounds.set(left: 0, top: 0, right: 0, bottom: 0)
        mPath.computeBounds(rect: &mPathBounds)
        mPathMatrix.reset()
        mPathMatrix.postRotate(degress: mPathRotation,px: mPathBounds.centerX(),py:mPathBounds.centerY())
        mPathMatrix.postScale(sx: mPathScaleX, sy: mPathScaleY ,px: mPathBounds.centerX(),py:mPathBounds.centerY())
        mPathMatrix.postTranslate(dx: mPathTranslationX, dy: mPathTranslationY)



        mPath.transform(matrix: mPathMatrix)

    }





    public func invalidateSelf(){
//        setNeedsDisplay()
        drawLayer()
    }



    private func makeTransform(_ animated:Bool = false){
        if(mIsTranslationPercent){
            mTranslationX = (mTranslationX * frame.width) + mTranslationPlusX
            mTranslationY = (mTranslationY * frame.height) + mTranslationPlusY
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

}
