//
//  SkiaDrawable.swift
//  Pods
//
//  Created by Juan J LF on 6/1/21.
//

//import UIKit
//import SkiaKit
//
//public class SkiaDrawable: CALayer {
//
//    public enum Shape {
//        case circle,
//             svgPath,
//             radiusRelativeToWidth,
//             radiusRelativeToHeight,
//             none
//    }
//
//
//    //MARK: layer propertys
//    private var mRotationX :CGFloat = 0
//    private var mRotationY :CGFloat = 0
//    private var mRotationZ :CGFloat = 0
//    private var mIsRotationX : Bool = false
//    private var mIsRotationY : Bool = false
//    private var mIsRotationZ : Bool = false
//    private var mTranslationX : CGFloat = 0
//    private var mTranslationY : CGFloat = 0
//
//    private var mTranslationPlusX : CGFloat = 0
//    private var mTranslationPlusY : CGFloat = 0
//    private var mIsTranslationPercent : Bool = false
//    private var mScaleX  : CGFloat = 1
//    private var mScaleY  : CGFloat = 1
//    private var mInsetX : CGFloat = 0
//    private var mInsetY : CGFloat = 0
//    private var mBaseRect = CGRect()
//    private var mRect = CGRect()
//    private var mRadius :[CGFloat] = [0,0,0,0]
//    private var mShape = Shape.none
//    private var mSvgPath = ""
//    private var mSvgAlign = "xMidYMid"
//    private var mSvgAspect = ViewBox.AspectRatio.meet
//    private var mVbRect = CGRect()
//
//
//
//
//    //MARK: Path propertys
//    private var mPath  = UIBezierPath()
//    private var mPathScaleX:CGFloat = 1
//    private var mPathScaleY:CGFloat = 1
//    private var mPathTranslationX:CGFloat = 0
//    private var mPathTranslationY:CGFloat = 0
//    private var mPathRotation:CGFloat = 0
//    private var mIsPathTranslationPercent = false
//    private var mPathTranslationPlusX:CGFloat = 0
//    private var mPathTranslationPlusY:CGFloat = 0
//
//    public override init() {
//        super.init()
//    }
//
//
//
//
//    //MARK: Path set and get
//    @discardableResult
//   public func setPathScale(sx:CGFloat,sy:CGFloat)-> SkiaDrawable{
//       mPathScaleX = sx
//       mPathScaleY = sy
//       return self
//   }
//    @discardableResult
//   public func setPathRotation(degrees: CGFloat) -> SkiaDrawable{
//       mPathRotation = degrees
//       return self
//   }
//    @discardableResult
//   public func setPathTranslation(dx:CGFloat,dy:CGFloat)-> SkiaDrawable {
//      mIsPathTranslationPercent = false
//       mPathTranslationX = dx
//       mPathTranslationY = dy
//       return self
//   }
//   @discardableResult
//   public func setPathTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0, plusY:CGFloat = 0)-> SkiaDrawable {
//       mPathTranslationX = percentX
//       mPathTranslationY = percentY
//       mPathTranslationPlusX = plusX
//       mPathTranslationPlusY = plusY
//       mIsPathTranslationPercent = true
//       return self
//  }
//
//
//    //MARK: set and get
//
//    @discardableResult
//   public func setShadowOffset(p:CGSize) -> SkiaDrawable{
//       super.shadowOffset = p
//       return self
//   }
//    @discardableResult
//   public func setShadowRadius(r:CGFloat) -> SkiaDrawable{
//       super.shadowRadius = r
//       return self
//   }
//    @discardableResult
//   public func setShadowOpacity(o:Float) -> SkiaDrawable{
//       super.shadowOpacity = o
//       return self
//   }
//    @discardableResult
//   public func setShadowColor(c:CGColor) -> SkiaDrawable{
//       super.shadowColor = c
//       return self
//   }
//
//    //MARK: STROKE SET
//
//    @discardableResult
//   public func setStrokeWidth(w:CGFloat) -> SkiaDrawable{
//
//       return self
//   }
//    @discardableResult
//   public func setStrokeColor(color:CGColor) -> SkiaDrawable{
//
//       return self
//   }
//
//    //MARK: LAYER SET
//
//    @discardableResult
//    public func setSvgPath(d:String,viewBox:[CGFloat] = [0,0,0,0],align:String = "xMidYMid",aspect:ViewBox.AspectRatio = .meet) -> SkiaDrawable{
//        mSvgPath = d
//        mSvgAlign = align
//        mSvgAspect = aspect
//
//        mVbRect.origin.x = viewBox[0]
//        mVbRect.origin.y = viewBox[1]
//        mVbRect.size.width = viewBox[2]
//        mVbRect.size.height = viewBox[3]
//
//
//       return self
//   }
//    @discardableResult
//   public func setShape(s:Shape) -> SkiaDrawable{
//       mShape = s
//       return self
//   }
//    @discardableResult
//   public func setRadius(v:CGFloat) -> SkiaDrawable{
//       mRadius = [v,v,v,v]
//       return self
//   }
//
//    @discardableResult
//    public func setRadius(topLeft:CGFloat,topRight:CGFloat,bottomLeft:CGFloat,bottomRight:CGFloat) -> SkiaDrawable{
//       mRadius = [topLeft,topRight,bottomLeft,bottomRight]
//       return self
//   }
//    @discardableResult
//   public func setFillColor(c:CGColor) -> SkiaDrawable{
//
//       return self
//   }
//
//
//     @discardableResult
//    public func setInset(dx:CGFloat,dy:CGFloat) -> SkiaDrawable{
//        mInsetY = dy.normalizedNotNegative()
//        mInsetX = dx.normalizedNotNegative()
//        return self
//    }
//
//    //MARK: layer set transform
//
//     @discardableResult
//    public func setScale(sx:CGFloat,sy:CGFloat)-> SkiaDrawable{
//        mScaleX = sx
//        mScaleY = sy
//        return self
//    }
//     @discardableResult
//    public func setRotationZ(degrees: CGFloat) -> SkiaDrawable{
//        mRotationZ = degrees
//        mIsRotationZ = true
//        return self
//    }
//
//    @discardableResult
//   public func setRotationX(degrees: CGFloat) -> SkiaDrawable{
//       mRotationX = degrees
//       mIsRotationX = true
//       return self
//   }
//    @discardableResult
//   public func setRotationY(degrees: CGFloat) -> SkiaDrawable{
//       mRotationY = degrees
//       mIsRotationY = true
//       return self
//   }
//     @discardableResult
//    public func setTranslation(dx:CGFloat,dy:CGFloat)-> SkiaDrawable {
//        mIsTranslationPercent = false
//        mTranslationX = dx
//        mTranslationY = dy
//        return self
//    }
//    @discardableResult
//    public func setTranslation(percentX:CGFloat,percentY:CGFloat, plusX:CGFloat = 0,plusY:CGFloat = 0)-> SkiaDrawable {
//        mTranslationX = percentX
//        mTranslationY = percentY
//        mTranslationPlusX = plusX
//        mTranslationPlusY = plusY
//        mIsTranslationPercent = true
//        return self
//   }
//
//
//    private var mFirstBounds = CGRect()
//    private var mBoundsX:CGFloat = 0
//    private var mBoundsY:CGFloat = 0
//    private var mBoundsWidth:CGFloat = 0
//    private var mBoundsHeight:CGFloat = 0
//    private var mIsBoundsDynamically = false
//    private var mIsBoundsPercentPos = false
//    private var mIsBoundsPercentSize = false
//    /**
//
//      Put the position and size of the layer where it will draw  relative in percentage-absolute to the bounds it received, naturally it always receives the bounds of the parent.
//
//      Percentage values  0 = 0% - 1 = 100%
//
//      - Parameters:
//          - x :  x origin
//          - y :  y origin
//          - width : a width value
//          - height : a height value
//          - percentPos : if origin is a percentage value, default false
//          - percentSize: if size is a percentage value, default false
//
//      */
//    @discardableResult
//    public func setBoundsDynamically(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,percentPos:Bool = false,percentSize:Bool = false)-> SkiaDrawable{
//        mIsBoundsDynamically = true
//        mIsBoundsPercentPos = percentPos
//        mIsBoundsPercentSize = percentSize
//        mBoundsX = x
//        mBoundsY = y
//        mBoundsWidth = width.normalizedNotNegative()
//        mBoundsHeight = height.normalizedNotNegative()
//        return self
//    }
//
//
//    //MARK: layer methods
//
//    public func onBoundsChange(_ frame: CGRect){
//        mFirstBounds.set(rect: frame)
//
//        if(mIsBoundsPercentPos){
//            mBoundsX *= frame.width
//            mBoundsY *= frame.height
//
//        }
//        if(mIsBoundsPercentSize){
//            mBoundsWidth *= frame.width
//            mBoundsHeight *= frame.height
//        }
//        if(mIsBoundsDynamically){
//
//            mBaseRect.origin.x = mBoundsX
//            mBaseRect.origin.y = mBoundsY
//            mBaseRect.size.width = mBoundsWidth
//            mBaseRect.size.height = mBoundsHeight
//        }else{
//            mBaseRect.set(rect: frame)
//        }
//
//        super.frame = mBaseRect
//        super.position.x = mBaseRect.width / 2
//        super.position.y = mBaseRect.height / 2
//        invalidateSelf()
//    }
//
//
//
//    public override func display() {
//        super.display()
//        if(mFirstBounds.width > 0 && mFirstBounds.height > 0){
//            setupRect()
//            // Create the Skia Context
//            let scale : CGFloat = 1.0
//            let info = ImageInfo(width: Int32 (mBaseRect.width), height: Int32 (mBaseRect.height * scale), colorType: .bgra8888, alphaType: .premul)
//            if info.width == 0 || info.height == 0 {
//                return
//            }
//
//
//
//            if let bmp = try? Bitmap(info){
//
//              let canvas = Canvas(bmp)
//
//                 //draw canvas aqui
//                drawAny(canvas: canvas, width: info.width, height: info.height)
//                canvas.flush ()
//
//                let pixels = bmp.getPixels()
//
//                guard let buffer = pixels.buffer else { return }
//
//                guard let dataProvider = CGDataProvider(dataInfo: nil, data: buffer, size: info.bytesSize, releaseData: {ctx, ptr, size in }) else {
//
//                    return
//                }
//                let colorSpace = CGColorSpaceCreateDeviceRGB()
//                let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue).union(.byteOrder32Little)
//                if let image = CGImage(width: Int(info.width), height: Int(info.height), bitsPerComponent: 8, bitsPerPixel: Int(info.bytesPerPixel*8), bytesPerRow: info.rowBytes, space: colorSpace, bitmapInfo: bitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent) {
//
//                    self.contents = image
//
//                }
//            }
//            makeTransform()
//        }
//
//    }
//
//    let path = Path()
//    let paint = Paint()
//    //paint letras ,maskfilter los otros, matrix
//    public func drawAny(canvas: Canvas, width: Int32, height: Int32) {
//
//
//        path.addCircle(x: Float(width/2), y: Float(height/2), radius: Float(width/2))
//
//
//        paint.isAntialias = true
//        paint.color = Color.RED
//        paint.style = Paint.Style.fill
//        paint.imageFilter = DropShadowImageFilter(radius: 3, offsetX: 10, offsetY: 10, color: Color.BLACK, shadowMode: .DRAW_SHADOW_AND_FOREGROUND)
//
//        canvas.drawPath(path, paint)
//
//
//    }
//
//    private func setupRect(){
//        mRect.set(rect: mBaseRect)
//        mRect.setInset(dx: mInsetX, dy: mInsetY)
////        let strokeInset = super.lineWidth / 2
////        mRect.setInset(dx: strokeInset, dy: strokeInset)
//
//
//
//    }
//
//    private func setupPath(){
//        mPath.removeAllPoints()
//        switch mShape {
//        case .circle:
//            let r = min(mRect.width, mRect.height) / 2
//            mRadius = [r,r,r,r]
//            //cw
//            mPath.addRoundRect(mRect, radius: mRadius)
//            break
//        case .radiusRelativeToHeight,.radiusRelativeToWidth :
//            let tl = mRadius[0].normalized()
//            let tr = mRadius[1].normalized()
//            let bl = mRadius[2].normalized()
//            let br = mRadius[3].normalized()
//            var size = mShape == .radiusRelativeToWidth ? mRect.width : 0
//            size = mShape == .radiusRelativeToHeight ? mRect.height : size
//            mRadius[0] = tl * size
//            mRadius[1] = tr * size
//            mRadius[2] = bl * size
//            mRadius[3] = br * size
//            //cw
//            mPath.addRoundRect(mRect, radius: mRadius)
//            break
//
//        case .svgPath:
//                mPath = PathParser.parse(d: mSvgPath)
//                if mVbRect.width > 0 && mVbRect.height > 0 {
//                    let trans = ViewBox.transform(vbRect: mVbRect, eRect: mRect, align: mSvgAlign, meetOrSlice: mSvgAspect)
//
//                    mPath.apply(trans)
//                }
//
//
//        default:
//            mPath.addRoundRect(mRect, radius: mRadius)
//        }
//
//        //path transform
//        if(mIsPathTranslationPercent){
//            mPathTranslationX = (mPathTranslationX * mBaseRect.width) + mPathTranslationPlusX
//            mPathTranslationY = (mPathTranslationY * mBaseRect.height) + mPathTranslationPlusY
//        }
//
//        //first translate for rotate and scale from center
//        let t = CGAffineTransform.identity
//            .translatedBy(x: mPathTranslationX, y: mPathTranslationY)
//
//            .translatedBy(x: mPath.bounds.center.x, y: mPath.bounds.center.y)
//            .rotated(by: mPathRotation.toRadians())
//            .scaledBy(x: mPathScaleX, y: mPathScaleY)
//            .translatedBy(x: -mPath.bounds.center.x , y: -mPath.bounds.center.y)
//
//
//
//        mPath.apply(t)
////
////        super.path = mPath.cgPath
////        super.shadowPath = mPath.cgPath
//    }
//
//
//
//
//
//
//
//    public func invalidateSelf(){
//        setNeedsDisplay()
//    }
//
//
//
//    private func makeTransform(_ animated:Bool = false){
//        if(mIsTranslationPercent){
//            mTranslationX = (mTranslationX * mFirstBounds.width) + mTranslationPlusX
//            mTranslationY = (mTranslationY * mFirstBounds.height) + mTranslationPlusY
//        }
//        if(animated && duration > 0){
//            applyTransform()
//        }else {
//            disableAnimation()
//            applyTransform()
//            commit()
//        }
//    }
//    private func applyTransform(){
//
//        var perspective = CATransform3DIdentity
//
//
//        perspective.m34 = 1 / -400;
//
//        if(mIsRotationX){
//            perspective = CATransform3DRotate(perspective, -mRotationX.toRadians(), 1, 0, 0)
//        }
//        if(mIsRotationY){
//            perspective = CATransform3DRotate(perspective, -mRotationY.toRadians(), 0, 1, 0)
//        }
//
//
//
//        var normal = CATransform3DIdentity;
//
//        if(mIsRotationZ){
//            normal = CATransform3DRotate(normal, mRotationZ.toRadians(), 0, 0, 1)
//        }
//        //first translation for for scale from center
//        normal = CATransform3DTranslate(normal, mTranslationX, mTranslationY, 0)
//        normal = CATransform3DScale(normal, mScaleX, mScaleX, 1)
//
//
//        self.transform = CATransform3DConcat(perspective, normal)
//    }
//    private func disableAnimation(){
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//    }
//
//    private func commit(){
//        CATransaction.commit()
//    }
//
//
//
//
//    public override init(layer: Any) {
//        super.init(layer: layer)
//
//    }
//    public required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
