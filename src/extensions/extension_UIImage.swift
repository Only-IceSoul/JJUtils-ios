//
//  extension_UIImage.swift
//  jjutils
//
//  Created by Juan J LF on 6/4/21.
//

import UIKit
import CoreImage



public extension UIImage{
    
    func blur(_ radius:Float) -> UIImage? {
        if radius <= 0 {  return self }
        guard let imageToBlur = CIImage(image: self),let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur") else { return nil}
        gaussianBlurFilter.setValue(imageToBlur, forKey: kCIInputImageKey)
        gaussianBlurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        guard let resultImg = gaussianBlurFilter.outputImage else { return nil}
        let final = resultImg.cropped(to: imageToBlur.extent)
        return UIImage(ciImage: final)
    }
    
    func blurCI(_ radius:Float) -> CIImage? {
        if radius <= 0 {  return nil }
        guard let imageToBlur = CIImage(image: self),let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur") else { return nil}
        gaussianBlurFilter.setValue(imageToBlur, forKey: kCIInputImageKey)
        gaussianBlurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        guard let resultImg = gaussianBlurFilter.outputImage else { return nil}
        let final = resultImg.cropped(to: imageToBlur.extent)
        return final
    }
}
