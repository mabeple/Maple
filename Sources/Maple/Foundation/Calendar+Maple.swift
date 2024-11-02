//
//  Calendar+Maple.swift
//  Maple
//
//  Created by cy on 2024/11/2.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation

extension Calendar: MabpleCompatibleValue { }

// MARK: - Methods

public extension MabpleWrapper where Base == Calendar {
    /// Return the number of days in the month for a specified 'Date'.
    ///
    ///        let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///        Calendar.current.numberOfDaysInMonth(for: date) -> 31
    ///
    /// - Parameter date: the date form which the number of days in month is calculated.
    /// - Returns: The number of days in the month of 'Date'.
    func numberOfDaysInMonth(for date: Date) -> Int {
        return base.range(of: .day, in: .month, for: date)!.count
    }
}

#endif

