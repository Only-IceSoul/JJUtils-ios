//
//  extension_UIImage.swift
//  jjutils
//
//  Created by Juan J LF on 6/4/21.
//

import UIKit
import CoreImage



public extension UIImage{
    
    func blur(_ radius:Float) -> CIImage? {
        if radius <= 0 {  return nil }
        guard let imageToBlur = CIImage(image: self),let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur") else { return nil}
        gaussianBlurFilter.setValue(imageToBlur, forKey: kCIInputImageKey)
        gaussianBlurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        return  gaussianBlurFilter.outputImage?.cropped(to: imageToBlur.extent)
    }
    

}
