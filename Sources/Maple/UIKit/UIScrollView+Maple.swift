//
//  UIScrollView+Maple.swift
//  Maple
//
//  Created by cy on 2021/4/29.
//  Copyright © 2021 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension MabpleWrapper where Base: UIScrollView {
    
    /// Takes a snapshot of an entire ScrollView.
    ///
    ///    AnySubclassOfUIScrollView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIImage for rendered ScrollView.
    var snapshot: UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        UIGraphicsBeginImageContextWithOptions(base.contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = base.frame
        base.frame = CGRect(origin: base.frame.origin, size: base.contentSize)
        base.layer.render(in: context)
        base.frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// The currently visible region of the scroll view.
    var visibleRect: CGRect {
        let contentWidth = base.contentSize.width - base.contentOffset.x
        let contentHeight = base.contentSize.height - base.contentOffset.y
        return CGRect(origin: base.contentOffset,
                      size: CGSize(width: min(min(base.bounds.size.width, base.contentSize.width), contentWidth),
                                   height: min(min(base.bounds.size.height, base.contentSize.height), contentHeight)))
    }
}

// MARK: - Methods
public extension MabpleWrapper where Base: UIScrollView {
    
    /// Scroll to the top-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToTop(animated: Bool = true) {
        base.setContentOffset(CGPoint(x: base.contentOffset.x, y: -base.contentInset.top), animated: animated)
    }
    
    /// Scroll to the left-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToLeft(animated: Bool = true) {
        base.setContentOffset(CGPoint(x: -base.contentInset.left, y: base.contentOffset.y), animated: animated)
    }
    
    /// Scroll to the bottom-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToBottom(animated: Bool = true) {
        base.setContentOffset(
            CGPoint(x: base.contentOffset.x, y: max(0, base.contentSize.height - base.bounds.height) + base.contentInset.bottom),
            animated: animated)
    }
    
    /// Scroll to the right-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToRight(animated: Bool = true) {
        base.setContentOffset(
            CGPoint(x: max(0, base.contentSize.width - base.bounds.width) + base.contentInset.right, y: base.contentOffset.y),
            animated: animated)
    }
    
    /// Scroll up one page of the scroll view.
    /// If `isPagingEnabled` is `true`, the previous page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollUp(animated: Bool = true) {
        let minY = -base.contentInset.top
        let y = max(minY, base.contentOffset.y - base.bounds.height)
        base.setContentOffset(CGPoint(x: base.contentOffset.x, y: y), animated: animated)
    }
    
    /// Scroll left one page of the scroll view.
    /// If `isPagingEnabled` is `true`, the previous page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollLeft(animated: Bool = true) {
        let minX = -base.contentInset.left
        let x = max(minX, base.contentOffset.x - base.bounds.width)
        base.setContentOffset(CGPoint(x: x, y: base.contentOffset.y), animated: animated)
    }
    
    /// Scroll down one page of the scroll view.
    /// If `isPagingEnabled` is `true`, the next page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollDown(animated: Bool = true) {
        let maxY = max(0, base.contentSize.height - base.bounds.height) + base.contentInset.bottom
        let y = min(maxY, base.contentOffset.y + base.bounds.height)
        base.setContentOffset(CGPoint(x: base.contentOffset.x, y: y), animated: animated)
    }
    
    /// Scroll right one page of the scroll view.
    /// If `isPagingEnabled` is `true`, the next page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollRight(animated: Bool = true) {
        let maxX = max(0, base.contentSize.width - base.bounds.width) + base.contentInset.right
        let x = min(maxX, base.contentOffset.x + base.bounds.width)
        base.setContentOffset(CGPoint(x: x, y: base.contentOffset.y), animated: animated)
    }
    
    /// Add padding to the top of the scroll view rect.
    /// - Parameters:
    ///   - top: amount of padding to apply to the top of the tableView rect.
    ///   - animated: set true to animate scroll (default is false).
    func addPaddingTop(_ padding: CGFloat, animated: Bool  = false) {
        base.contentInset = UIEdgeInsets(top: padding, left: 0, bottom: 0, right: 0)
        base.setContentOffset(CGPoint(x: 0, y: -padding), animated: animated)
    }
}
#endif
