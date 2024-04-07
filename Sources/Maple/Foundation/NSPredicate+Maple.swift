//
//  NSPredicate+Maple.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation

extension NSPredicate: MabpleCompatible { }

// MARK: - Properties

public extension MabpleWrapper where Base: NSPredicate {
    /// Returns a new predicate formed by NOT-ing the predicate.
    var not: NSCompoundPredicate {
        return NSCompoundPredicate(notPredicateWithSubpredicate: base)
    }
}

// MARK: - Methods

public extension MabpleWrapper where Base: NSPredicate {
    /// Returns a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameter predicate: NSPredicate.
    /// - Returns: NSCompoundPredicate.
    func and(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [base, predicate])
    }

    /// Returns a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameter predicate: NSPredicate.
    /// - Returns: NSCompoundPredicate.
    func or(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(orPredicateWithSubpredicates: [base, predicate])
    }
}

// MARK: - Operators

public extension NSPredicate {
    /// Returns a new predicate formed by NOT-ing the predicate.
    /// - Parameters: rhs: NSPredicate to convert.
    /// - Returns: NSCompoundPredicate
    static prefix func ! (rhs: NSPredicate) -> NSCompoundPredicate {
        return rhs.mp.not
    }

    /// Returns a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static func + (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs.mp.and(rhs)
    }

    /// Returns a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static func | (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs.mp.or(rhs)
    }

    /// Returns a new predicate formed by remove the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate
    static func - (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs + !rhs
    }
}

#endif
