//
//  UIImage+Alpha.swift
//  doodlAR
//
//  Created by Eve Le on 1/10/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
