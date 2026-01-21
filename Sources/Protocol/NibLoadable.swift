//
//  NibLoadable.swift
//  Maple
//
//  Created by cy on 2020/4/2.
//

@MainActor
public protocol NibLoadable {}

#if canImport(UIKit)
import UIKit

public extension NibLoadable where Self: UIView {
    static func loadFromNib(_ name: String? = nil) -> Self {
        let loadName = name ?? "\(self)"
        guard let nibObjects = Bundle.main.loadNibNamed(loadName, owner: nil, options: nil),
              let view = nibObjects.first as? Self else {
            fatalError("Could not load view with type \(self) from nib named '\(loadName)'")
        }
        return view
    }
}

public extension NibLoadable where Self: UIViewController {
    static func loadFromStoryboard(_ name: String? = nil, with identifier: String? = nil) -> Self {
        let loadName = name ?? "\(self)"
        let storyboard = UIStoryboard(name: loadName, bundle: nil)
        
        if let sbId = identifier {
            guard let viewController = storyboard.instantiateViewController(withIdentifier: sbId) as? Self else {
                fatalError("Could not instantiate view controller with type \(self) and identifier '\(sbId)' from storyboard named '\(loadName)'")
            }
            return viewController
        } else {
            guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
                fatalError("Could not instantiate initial view controller with type \(self) from storyboard named '\(loadName)'")
            }
            return viewController
        }
    }
}
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NibLoadable where Self: NSView {
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static func loadFromNib(_ name: String? = nil) -> Self {
        let loadName = name ?? "\(self)"
        var topLevelObjects: NSArray?
        
        guard Bundle.main.loadNibNamed(NSNib.Name(loadName), owner: Self.self, topLevelObjects: &topLevelObjects),
              let results = topLevelObjects else {
            fatalError("Could not load nib named '\(loadName)'")
        }
        
        let views = Array<Any>(results).filter { $0 is Self }
        guard let view = views.last as? Self else {
            fatalError("Could not find view with type \(self) in nib named '\(loadName)'")
        }
        
        return view
    }
}
#endif
