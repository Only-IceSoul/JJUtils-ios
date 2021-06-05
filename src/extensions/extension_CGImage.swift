//
//  extension_CGImage.swift
//  jjutils
//
//  Created by Juan J LF on 6/4/21.
//

import UIKit
import CoreImage



public extension CGImage{
    
    func blur(_ radius:Float) -> UIImage? {
        if radius <= 0 {  return UIImage(cgImage: self) }
        let imageToBlur = CIImage(cgImage: self)
        guard let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur") else { return nil}
        gaussianBlurFilter.setValue(imageToBlur, forKey: kCIInputImageKey)
        gaussianBlurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        guard let resultImg = gaussianBlurFilter.outputImage else { return nil}
        return UIImage(ciImage: resultImg.cropped(to: imageToBlur.extent))
    }
}
