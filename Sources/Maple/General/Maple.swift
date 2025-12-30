//
//  Maple.swift
//  Maple
//
//  Created by cy on 2020/4/5.
//  Copyright © 2020 cy. All rights reserved.
//

public struct MapleWrapper<Base>: @unchecked Sendable {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol MapleCompatible: AnyObject { }

extension MapleCompatible {
    public var mp: MapleWrapper<Self> {
        get { MapleWrapper(self) }
        set { }
    }
}

public protocol MapleCompatibleValue { }

extension MapleCompatibleValue {
    public var mp: MapleWrapper<Self> {
        get { MapleWrapper(self) }
        set { }
    }
}


