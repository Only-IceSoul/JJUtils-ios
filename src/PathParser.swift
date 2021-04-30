//
//  PathParser.swift
//  testany
//
//  Created by Juan J LF on 4/27/21.
//

import UIKit


public class PathParser {
    

    private static var i :Int = 0;
    private static var l : Int = 0;
    private static var s : String = "";
    private static let  mPath  = UIBezierPath()
    static var elements = [PathElement]()

    private static var mPenX : CGFloat = 0
    private static var mPenY : CGFloat = 0
    private static var mPivotX : CGFloat = 0
    private static var mPivotY : CGFloat = 0
    private static var mPenDownX : CGFloat = 0
    private static var mPenDownY : CGFloat = 0
    private static var mPenDown : Bool = false

    public static func parse( d:String?) -> UIBezierPath {
        elements = [PathElement]();
        mPath.removeAllPoints()
        if(d == nil ){
            return mPath;
        }
        if(d!.isEmpty ){
            return mPath;
        }
        var prev_cmd : Character = Character(" ");
        l = d!.count
        s = d!;
        i = 0;

        mPenX = 0
        mPenY = 0
        mPivotX = 0
        mPivotY = 0
        mPenDownX = 0
        mPenDownY = 0
        mPenDown = false
        
        while (i < l) {
                   skip_spaces();

                   if (i >= l) {
                       break;
                   }

            let has_prev_cmd = prev_cmd != " ";
            let first_char = s[i];

                   if (!has_prev_cmd && first_char != "M" && first_char != "m") {
                       // The first segment must be a MoveTo.
                      fatalError("Unexpected character \(first_char) (i=\(i), s=\(s)");
                   }

                   // TODO: simplify
                   var is_implicit_move_to = false
                   var cmd:Character = Character(" ")
                   if (is_cmd(c: first_char)) {
                       is_implicit_move_to = false;
                       cmd = first_char;
                       i += 1;
                   } else if (is_number_start(c: first_char) && has_prev_cmd) {
                       if (prev_cmd == "Z" || prev_cmd == "z") {
                           // ClosePath cannot be followed by a number.
                           fatalError("Unexpected number after z (s=\(s))");
                       }

                       if (prev_cmd == "M" || prev_cmd == "m") {
                           // "If a moveto is followed by multiple pairs of coordinates,
                           // the subsequent pairs are treated as implicit lineto commands."
                           // So we parse them as LineTo.
                           is_implicit_move_to = true;
                        if (is_absolute(c: prev_cmd)) {
                               cmd = "L";
                           } else {
                               cmd = "l";
                           }
                       } else {
                           is_implicit_move_to = false;
                           cmd = prev_cmd;
                       }
                   } else {
                       fatalError("Unexpected character \(first_char) (i=\(i), s=\(s)");
                   }

                 let absolute = is_absolute(c: cmd);
       
                   switch (cmd) {
                       case "m":
                           move(parse_list_number(), parse_list_number());
                           break;
                       
                       case "M":
                           moveTo(parse_list_number(), parse_list_number());
                           break;
                       
                       case "l":
                           line(parse_list_number(), parse_list_number());
                           break;
                       
                       case "L":
                           lineTo(parse_list_number(), parse_list_number());
                           break;
                       
                       case "h":
                           line(parse_list_number(), 0);
                           break;
                       
                       case "H":
                           lineTo(parse_list_number(), mPenY);
                           break;
                       
                       case "v":
                           line(0, parse_list_number());
                           break;
                       
                       case "V":
                           lineTo(mPenX, parse_list_number());
                           break;
                       
                       case "c":
                           curve(parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number());
                           break;
                       
                       case "C":
                           curveTo(parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number());
                           break;
                       
                       case "s":
                           smoothCurve(parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number());
                           break;
                       
                       case "S":
                           smoothCurveTo(parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number());
                           break;
                       
                       case "q":
                           quadraticBezierCurve(parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number());
                           break;
                       
                       case "Q":
                           quadraticBezierCurveTo(parse_list_number(), parse_list_number(), parse_list_number(), parse_list_number());
                           break;
                       
                       case "t":
                        smoothQuadraticBezierCurve(c1x: parse_list_number(), c1y: parse_list_number());
                           break;
                       
                       case "T":
                           smoothQuadraticBezierCurveTo(parse_list_number(), parse_list_number());
                           break;
                       
                       case "a":
                        arc(rx: parse_list_number(), ry: parse_list_number(), rotation: parse_list_number(), outer: parse_flag(), clockwise: parse_flag(), x: parse_list_number(), y: parse_list_number());
                           break;
                       
                       case "A":
                           arcTo(parse_list_number(), parse_list_number(), parse_list_number(), parse_flag(), parse_flag(), parse_list_number(), parse_list_number());
                           break;
                       
                       case "z",
                            "Z":
                           close();
                           break;
                    
                       default:
                           fatalError("Unexpected comand \(cmd) (s=\(s)");
                       
                   }


                   if (is_implicit_move_to) {
                       if (absolute) {
                           prev_cmd = "M";
                       } else {
                           prev_cmd = "m";
                       }
                   } else {
                       prev_cmd = cmd;
                   }

               }

        
        return mPath

    }
    
    private static func move(_ x:CGFloat,_ y:CGFloat) {
           moveTo(x + mPenX, y + mPenY);
       }

   private static func moveTo(_ x:CGFloat,_ y:CGFloat) {
       //FLog.w(ReactConstants.TAG, "move x: " + x + " y: " + y);
       mPenDownX = x
        mPivotX = x
        mPenX = x
       mPenDownY = y
        mPivotY = y
        mPenY = y
       mPath.move(to: CGPoint(x: x, y: y))
       elements.append(PathElement(ElementType.kCGPathElementMoveToPoint, [ CGPoint(x:x,y:y) ] ));
   }

   private static func line(_ x:CGFloat,_ y:CGFloat) {
       lineTo(x + mPenX, y + mPenY);
   }

    
    private static func lineTo(_ x:CGFloat,_ y:CGFloat) {
         //FLog.w(ReactConstants.TAG, "line x: " + x + " y: " + y);
         setPenDown();
         mPivotX = x
          mPenX = x
         mPivotY = y
         mPenY = y
         mPath.addLine(to: CGPoint(x: x, y: y))
        elements.append( PathElement(.kCGPathElementAddLineToPoint, [CGPoint(x:x,y:y)] ));
     }

    private static func curve(_ c1x:CGFloat,_ c1y:CGFloat,_ c2x:CGFloat,_ c2y:CGFloat,_ ex:CGFloat,_ ey:CGFloat) {
         curveTo(c1x + mPenX, c1y + mPenY, c2x + mPenX, c2y + mPenY, ex + mPenX, ey + mPenY);
     }

    private static func curveTo(_ c1x:CGFloat,_ c1y:CGFloat,_ c2x:CGFloat,_ c2y:CGFloat,_ ex:CGFloat,_ ey:CGFloat) {
         //FLog.w(ReactConstants.TAG, "curve c1x: " + c1x + " c1y: " + c1y + "ex: " + ex + " ey: " + ey);
         mPivotX = c2x;
         mPivotY = c2y;
         cubicTo(c1x, c1y, c2x, c2y, ex, ey);
     }
    private static func cubicTo(_ c1x:CGFloat,_ c1y:CGFloat,_ c2x:CGFloat,_ c2y:CGFloat,_ ex:CGFloat,_ ey:CGFloat) {
           setPenDown();
           mPenX = ex;
           mPenY = ey;
        mPath.addCurve(to: CGPoint(x: ex, y: ey), controlPoint1: CGPoint(x: c1x, y: c1y), controlPoint2: CGPoint(x: c2x, y: c2y))
        elements.append(PathElement(.kCGPathElementAddCurveToPoint, [CGPoint(x: c1x,y: c1y),  CGPoint(x: c2x, y:c2y), CGPoint(x:ex,y:ey)] ));
       }

       private static func smoothCurve(_ c1x:CGFloat,_ c1y:CGFloat,_ ex:CGFloat,_ ey:CGFloat) {
           smoothCurveTo(c1x + mPenX, c1y + mPenY, ex + mPenX, ey + mPenY);
       }

       private static func smoothCurveTo(_ c1xx:CGFloat,_ c1yy:CGFloat,_ ex:CGFloat,_ ey:CGFloat) {
           //FLog.w(ReactConstants.TAG, "smoothcurve c1x: " + c1x + " c1y: " + c1y + "ex: " + ex + " ey: " + ey);
        let c2x = c1xx;
        let c2y = c1yy;
        let c1x = (mPenX * 2) - mPivotX;
           let c1y = (mPenY * 2) - mPivotY;
           mPivotX = c2x;
           mPivotY = c2y;
           cubicTo(c1x, c1y, c2x, c2y, ex, ey);
       }
    
    private static func quadraticBezierCurve(_ c1x:CGFloat,_ c1y:CGFloat,_ c2x:CGFloat,_ c2y:CGFloat) {
          quadraticBezierCurveTo(c1x + mPenX, c1y + mPenY, c2x + mPenX, c2y + mPenY);
      }

      private static func quadraticBezierCurveTo(_ c1xx:CGFloat,_  c1yy:CGFloat,_  c2xx:CGFloat,_ c2yy:CGFloat) {
          //FLog.w(ReactConstants.TAG, "quad c1x: " + c1x + " c1y: " + c1y + "c2x: " + c2x + " c2y: " + c2y);
          mPivotX = c1xx;
          mPivotY = c1yy;
        let ex = c2xx;
        let ey = c2yy;
        let c2x = (ex + c1xx * 2) / 3;
        let c2y = (ey + c1yy * 2) / 3;
        let c1x = (mPenX + c1xx * 2) / 3;
        let c1y = (mPenY + c1yy * 2) / 3;
          cubicTo(c1x, c1y, c2x, c2y, ex, ey);
      }
    
    private static func smoothQuadraticBezierCurve( c1x:CGFloat,  c1y:CGFloat) {
         smoothQuadraticBezierCurveTo(c1x + mPenX, c1y + mPenY);
     }

    private static func smoothQuadraticBezierCurveTo(_ c1xx:CGFloat,_ c1yy:CGFloat) {
         //FLog.w(ReactConstants.TAG, "smoothquad c1x: " + c1x + " c1y: " + c1y);
        let c2x = c1xx;
        let c2y = c1yy;
         
        let c1x = (mPenX * 2) - mPivotX;
        let c1y = (mPenY * 2) - mPivotY;
         quadraticBezierCurveTo(c1x, c1y, c2x, c2y);
     }
    
    private static func arc( rx:CGFloat,  ry:CGFloat,  rotation:CGFloat,outer:Bool, clockwise:Bool,  x:CGFloat,  y:CGFloat) {
           arcTo(rx, ry, rotation, outer, clockwise, x + mPenX, y + mPenY);
    }

    
    private static func arcTo(_ rxxx:CGFloat,_ ryyy:CGFloat,_ rotation:CGFloat, _ outer:Bool,_ clockwise:Bool,_ xxx:CGFloat,_ yyy:CGFloat) {
           //FLog.w(ReactConstants.TAG, "arc rx: " + rx + " ry: " + ry + " rotation: " + rotation + " outer: " + outer + " clockwise: " + clockwise + " x: " + x + " y: " + y);
        let tX = mPenX;
        let tY = mPenY;
          var rx = rxxx
        var ry = ryyy
        var x = xxx
        var y = yyy

           ry = abs(ry == 0 ? (rx == 0 ? (y - tY) : rx) : ry);
           rx = abs(rx == 0 ? (x - tX) : rx);

           if (rx == 0 || ry == 0 || (x == tX && y == tY)) {
               lineTo(x, y);
               return;
           }

        let rad =  rotation.toRadians()
        let coss =  cos(rad);
        let sinn =  sin(rad);
           x -= tX;
           y -= tY;

           // Ellipse Center
        var cx :CGFloat = coss * x / 2 + sinn * y / 2;
        var cy :CGFloat = -sinn * x / 2 + coss * y / 2;
        let rxry :CGFloat = rx * rx * ry * ry;
        let rycx :CGFloat = ry * ry * cx * cx;
        let rxcy :CGFloat = rx * rx * cy * cy;
        var a :CGFloat = rxry - rxcy - rycx;

           if (a < 0) {
               a = sqrt(1 - a / rxry);
               rx *= a;
               ry *= a;
               cx = x / 2;
               cy = y / 2;
           } else {
               a = sqrt(a / (rxcy + rycx));

               if (outer == clockwise) {
                   a = -a;
               }
            let cxd = -a * cy * rx / ry;
            let cyd = a * cx * ry / rx;
               cx = coss * cxd - sinn * cyd + x / 2;
               cy = sinn * cxd + coss * cyd + y / 2;
           }

           // Rotation + Scale Transform
        let xx = coss / rx;
        let yx = sinn / rx;
        let xy = -sinn / ry;
        let yy = coss / ry;

           // Start and End Angle
        let sa =  atan2(xy * -cx + yy * -cy, xx * -cx + yx * -cy);
        let ea =  atan2(xy * (x - cx) + yy * (y - cy), xx * (x - cx) + yx * (y - cy));

           cx += tX;
           cy += tY;
           x += tX;
           y += tY;

           setPenDown();

           mPenX = x
            mPivotX = x;
           mPenY = y
            mPivotY = y;

           if (rx != ry || rad != 0) {
               print("bezier arc")
               arcToBezier(cx, cy, rx, ry, sa, ea, clockwise, rad);
           } else {
           
            let start =  sa.toDegrees()
            let end =  ea.toDegrees()
            var sweep = abs((start - end).truncatingRemainder(dividingBy: 360));
          //sweep 270
            if (outer) {
               if (sweep < 180) {
                   sweep = 360 - sweep;
               }
           } else {
               if (sweep > 180) {
                   sweep = 360 - sweep;
               }
           }


               if (!clockwise) {
                   sweep = -sweep;
               }

         

          
            mPath.addArc(withCenter: CGPoint(x: cx, y: cy), radius: rx, startAngle: start.toRadians(), endAngle: (start + sweep).toRadians(), clockwise: clockwise)

       
            elements.append(PathElement(.kCGPathElementAddCurveToPoint,[CGPoint(x: x, y: y)]))

           }
       }

    
    private static func close() {
          if (mPenDown) {
              mPenX = mPenDownX
              mPenY = mPenDownY
              mPenDown = false
              mPath.close()
            elements.append(PathElement(.kCGPathElementCloseSubpath, [CGPoint(x: mPenX, y: mPenY)]));
          }
      }
    private static func arcToBezier(_ cx:CGFloat,_ cy:CGFloat,_ rx:CGFloat,_ ry:CGFloat,_ sa:CGFloat, _ ea:CGFloat,_ clockwise:Bool,_ rad:CGFloat) {
           // Inverse Rotation + Scale Transform
        let coss:CGFloat =  cos(rad)
        let sinn:CGFloat = sin(rad);
        let xx = coss * rx;
        let yx = -sinn * ry;
        let xy = sinn * rx;
        let yy = coss * ry;
        var saa = sa

           // Bezier Curve Approximation
           var arc = ea - saa;
           if (arc < 0 && clockwise) {
               arc += CGFloat.pi * 2;
           } else if (arc > 0 && !clockwise) {
               arc -= CGFloat.pi * 2;
           }

        let n =  Int( ceil( abs(round(val: arc / (CGFloat.pi / 2)) )) )

        let step = arc / CGFloat(n);
        let k =  (4 / 3.0) * tan(step / 4);

        var x = cos(saa);
        var y = sin(saa);

        for _ in 0..<n {
            let cp1x = x - k * y;
            let cp1y = y + k * x;

               saa += step;
               x = cos(saa);
               y = sin(saa);

            let cp2x = x + k * y;
            let cp2y = y - k * x;

            let c1x = (cx + xx * cp1x + yx * cp1y);
            let c1y = (cy + xy * cp1x + yy * cp1y);
            let c2x = (cx + xx * cp2x + yx * cp2y);
            let c2y = (cy + xy * cp2x + yy * cp2y);
            let ex = (cx + xx * x + yx * y);
            let ey = (cy + xy * x + yy * y);

            mPath.addCurve(to: CGPoint(x: ex, y: ey), controlPoint1: CGPoint(x: c1x, y: c1y), controlPoint2: CGPoint(x: c2x, y: c2y))
               elements.append(PathElement(.kCGPathElementAddCurveToPoint,[CGPoint(x: c2x, y: c2y),CGPoint(x: ex, y: ey)] ))
                               
        }
    }
    
    private static func setPenDown() {
        if (!mPenDown) {
            mPenDownX = mPenX;
            mPenDownY = mPenY;
            mPenDown = true;
        }
    }

    private static func round(val:CGFloat) -> CGFloat {
        let multiplier =  CGFloat(pow(10.0, 4.0))
        var r = (val * multiplier)
        r.round()
        return r / multiplier
    }

    
    private static func skip_spaces() {
        while (i < l && s[i].isWhitespace){
            i += 1
        }
    }

    private static func is_cmd(c:Character) -> Bool {
        switch (c) {
            case "M",
             "m",
             "Z",
             "z",
             "L",
             "l",
             "H",
             "h",
             "V",
             "v",
             "C",
             "c",
             "S",
             "s",
             "Q",
             "q",
             "T",
             "t",
            "A",
             "a":
                return true;
        default:
            return false
        }

    }
    
    private static func is_number_start(c:Character) -> Bool {
         return (c >= "0" && c <= "9") || c == "." || c == "-" || c == "+";
     }

    private static func is_absolute(c:Character) -> Bool {
        return c.isUppercase
     }

    
    // By the SVG spec "large-arc" and "sweep" must contain only one char
    // and can be written without any separators, e.g.: 10 20 30 01 10 20.
    private static func parse_flag() -> Bool {
       skip_spaces();

        let c = s[i];
       switch (c) {
           case "0", "1":
               i += 1;
               if (i < l && s[i] == ",") {
                   i += 1;
               }
               skip_spaces();
               break;
           
           default:
            fatalError("Unexpected flag \(c) (i=\(i), s=\(s))");
       }

       return c == "1";
    }

    private static func parse_list_number() -> CGFloat{
         if (i == l) {
             fatalError("Unexpected end (s=\(s))")
         }

        let n = parse_number();
         skip_spaces();
         parse_list_separator();

         return n;
     }
      private static func parse_number() -> CGFloat {
          // Strip off leading whitespaces.
          skip_spaces();

          if (i == l) {
              fatalError("Unexpected end (s=\(s))")
          }

        let start = i;

          var c = s[i];

          // Consume sign.
          if (c == "-" || c == "+") {
              i += 1;
              c = s[i];
          }

          // Consume integer.
          if (c >= "0" && c <= "9") {
              skip_digits();
              if (i < l) {
                  c = s[i];
              }
          } else if (c != ".") {
              fatalError("Invalid number formating character \(c) (i=\(i), s=\(s)")
          }

          // Consume fraction.
          if (c == ".") {
              i += 1;
              skip_digits();
              if (i < l) {
                  c = s[i]
              }
          }

          if ((c == "e" || c == "E") && i + 1 < l) {
            let c2 = s[i + 1]
              // Check for `em`/`ex`.
              if (c2 != "m" && c2 != "x") {
                  i += 1;
                  c = s[i]

                  if (c == "+" || c == "-") {
                      i += 1;
                      skip_digits();
                  } else if (c >= "0" && c <= "9") {
                      skip_digits();
                  } else {
                    fatalError("Invalid number formating character \(c) (i=\(i), s=\(s)")
                  }
              }
          }

        let num = s.substring(with: start..<i)
        guard let n = Double(num) else {
            fatalError("Invalid number \(num) (start=\(start), i=\(i), s=\(s))")
        }

      

          return CGFloat(n);
      }
    
    private static func parse_list_separator() {
        if (i < l && s[i] == ",") {
               i += 1;
        }
    }
    
    private static func skip_digits() {
        while (i < l && (s[i].isASCII && s[i].isNumber)) {
            i+=1
        }
    }
}
