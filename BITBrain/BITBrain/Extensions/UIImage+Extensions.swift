//
//  UIImage+Extensions.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 18.12.24..
//

import Foundation
import UIKit

extension UIImage {

    func resizeTo(to targetSize: CGSize) -> UIImage? {
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Determine the scale factor that preserves aspect ratio
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        
        // Create a graphics context and draw the resized image
        UIGraphicsBeginImageContextWithOptions(scaledImageSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: scaledImageSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
