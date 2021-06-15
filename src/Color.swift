//
//  Color.swift
//  jjutils
//
//  Created by Juan J LF on 6/13/21.
//

import Foundation

public struct Color : Equatable {
    var color : UInt32 = 0
    
    public init (_ value: UInt32)
    {
        color = value
    }
    
    public init (r: UInt32, g: UInt32, b: UInt32, a: UInt32 = 0xff)
    {
        color = Color.toUInt32(r: r, g: g, b: b,a: a)
    }
    
    private static func toUInt32(r: UInt32, g: UInt32, b: UInt32, a: UInt32) -> UInt32{
       return (a << 24) | (r << 16) | (g << 8) | b
    }
    
    public init (hue: Float, saturation: Float, lightness: Float, alpha: UInt32 = 0xff)
    {
        // convert from percentages
        let h = hue / 360.0
        let s = saturation / 100.0
        let l = lightness / 100.0

        // RGB results from 0 to 255
        var r = l * 255.0
        var g = l * 255.0
        var b = l * 255.0

        // HSL from 0 to 1
        if (fabsf (s) > 0.001) {
            var v2 : Float
            if l < 0.5 {
                v2 = l * (1.0 + s);
            } else {
                v2 = (l + s) - (s * l)
            }
            let v1 = 2.0 * l - v2

            r = 255 * Color.hueToRgb (v1, v2, h + (1.0 / 3.0))
            g = 255 * Color.hueToRgb (v1, v2, h)
            b = 255 * Color.hueToRgb (v1, v2, h - (1.0 / 3.0))
        }

        self.color = Color.toUInt32(r: UInt32(r), g: UInt32(g), b: UInt32(b), a: alpha)
    }
    
    static func hueToRgb (_ v1: Float, _ v2: Float, _ vh: Float) -> Float
    {
        var vH = vh
        if vH < 0 {
            vH = vH + 1
        }
        if vH > 1 {
            vH = vH - 1
        }
            
        if (6 * vH) < 1 {
            return v1 + (v2 - v1) * 6 * vH
        }
        if (2 * vH) < 1 {
            return v2
        }
        if (3 * vH) < 2 {
            return v1 + (v2 - v1) * ((2.0 / 3.0) - vH) * 6
        }
        return v1
    }
    
    public static func parseColor(_ hex: String) -> UInt32? {
          var chars = Array(hex.hasPrefix("#") ? hex.dropFirst() : hex[...])
          let red, green, blue, alpha: UInt32
          switch chars.count {
          case 3:
              chars = chars.flatMap { [$0, $0] }
              fallthrough
          case 6:
              chars = ["F","F"] + chars
              fallthrough
          case 8:
              alpha = UInt32(strtoul(String(chars[0...1]), nil, 16))
              red   = UInt32(strtoul(String(chars[2...3]), nil, 16))
              green = UInt32(strtoul(String(chars[4...5]), nil, 16))
              blue  = UInt32(strtoul(String(chars[6...7]), nil, 16))
          default:
              return nil
          }
        return Color.toUInt32(r: red, g: green, b: blue, a: alpha)
      }
    
    public var alpha : UInt32 {
        get {
            (UInt32)((color >> 24) & 0xff)
        }
    }
    
    public var red : UInt32 {
        get {
            (UInt32)((color >> 16) & 0xff)
        }
    }
    
    public var green : UInt32 {
        get {
            (UInt32)((color >> 8) & 0xff)
        }
    }
    
    public var blue : UInt32 {
        get {
            (UInt32)(color  & 0xff)
        }
    }
    
    public static func red(color:UInt32) -> UInt32{
        return (color >> 16) & 0xff
    }
    public static func green(color:UInt32) -> UInt32{
        return (color >> 8) & 0xff
    }
    public static func blue(color:UInt32) -> UInt32{
        return color  & 0xff
    }
    
    
    public static var BLACK = UInt32(0xFF000000)
    public static var DKGRAY =  UInt32(0xFF444444)
    public static var GRAY =  UInt32(0xFF888888)
    public static var LTGRAY = UInt32(0xFFCCCCCC)
    public static var WHITE =  UInt32(0xFFFFFFFF)
    public static var RED = UInt32(0xFFFF0000)
    public static var GREEN =  UInt32(0xFF00FF00)
    public static var BLUE =  UInt32(0xFF0000FF)
    public static var YELLOW = UInt32(0xFFFFFF00)
    public static var CYAN =  UInt32(0xFF00FFFF)
    public static var MAGENTA = UInt32(0xFFFF00FF)
    public static var TRANSPARENT =  UInt32(0)
 

}
