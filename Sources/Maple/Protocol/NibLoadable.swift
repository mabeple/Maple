//
//  NibLoadable.swift
//  Maple
//
//  Created by cy on 2020/4/2.
//  Copyright © 2020 cy. All rights reserved.
//

public protocol NibLoadable {}

#if canImport(UIKit)
import UIKit
extension UIView: NibLoadable {}
extension UIViewController: NibLoadable {}

public extension NibLoadable where Self : UIView {
    static func loadFromNib(_ name : String? = nil) -> Self {
        let loadName = name == nil ? "\(self)" : name!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}

public extension NibLoadable where Self : UIViewController {
    static func loadFromStoryboard(_ name: String? = nil, with identifier: String? = nil) -> Self {
        
        let loadName = name == nil ? "\(self)" : name!
        guard let sbId = identifier else {
            return UIStoryboard(name: loadName, bundle: nil).instantiateInitialViewController() as! Self
        }
        
        return UIStoryboard(name: loadName, bundle: nil).instantiateViewController(withIdentifier: sbId) as! Self
    }
}
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
extension NSView: NibLoadable {}
public extension NibLoadable where Self : NSView {
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static func loadFromNib(_ name : String? = nil) -> Self {
        let loadName = name == nil ? "\(self)" : name!
        var topLevelArray: NSArray? = nil
        Bundle.main.loadNibNamed(NSNib.Name(loadName), owner: Self.self, topLevelObjects: &topLevelArray)
        guard let results = topLevelArray else { fatalError() }
        let views = Array<Any>(results).filter { $0 is Self }
        guard let view = views.last as? Self else { fatalError() }
        return view
    }
}
#endif
