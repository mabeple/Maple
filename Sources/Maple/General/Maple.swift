//
//  Maple.swift
//  Maple
//
//  Created by cy on 2020/4/5.
//  Copyright © 2020 cy. All rights reserved.
//

public struct MabpleWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol MabpleCompatible: AnyObject { }

public protocol MabpleCompatibleValue { }

extension MabpleCompatible {
    public var mp: MabpleWrapper<Self> {
        get { MabpleWrapper(self) }
        set { }
    }
}

extension MabpleCompatibleValue {
    public var mp: MabpleWrapper<Self> {
        get { MabpleWrapper(self) }
        set { }
    }
}


