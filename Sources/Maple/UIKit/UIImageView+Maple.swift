//
//  UIImageView+Maple.swift
//  Maple
//
//  Created by cy on 2020/11/16.
//  Copyright © 2020 cy. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Methods
public extension MabpleWrapper where Base: UIImageView {
    
    /// Make image view blurry
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = base.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        base.addSubview(blurEffectView)
        base.clipsToBounds = true
    }
    
    /// Blurred version of an image view
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    /// - Returns: blurred version of self.
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = base
        imgView.mp.blur(withStyle: style)
        return imgView
    }
}
#endif
