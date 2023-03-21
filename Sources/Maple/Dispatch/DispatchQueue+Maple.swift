//
//  DispatchQueue+Maple.swift
//  Maple
//
//  Created by cy on 2023/3/21.
//  Copyright © 2023 cy. All rights reserved.
//

#if canImport(Dispatch)
import Dispatch

// MARK: - Properties

public extension DispatchQueue {
    /// A Boolean value indicating whether the current dispatch queue is the main queue.
    static var isMainQueue: Bool {
        enum Static {
            static var key: DispatchSpecificKey<Void> = {
                let key = DispatchSpecificKey<Void>()
                DispatchQueue.main.setSpecific(key: key, value: ())
                return key
            }()
        }
        return DispatchQueue.getSpecific(key: Static.key) != nil
    }
    
    /// Returns a Boolean value indicating whether the current dispatch queue is the specified queue.
    ///
    /// - Parameter queue: The queue to compare against.
    /// - Returns: `true` if the current queue is the specified queue, otherwise `false`.
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()

        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }

        return DispatchQueue.getSpecific(key: key) != nil
    }
}

// MARK: - Methods
extension DispatchQueue: MabpleCompatible { }
public extension MabpleWrapper where Base: DispatchQueue {
    /// Runs passed closure asynchronous after certain time interval.
    ///
    /// - Parameters:
    ///   - delay: The time interval after which the closure will run.
    ///   - qos: Quality of service at which the work item should be executed.
    ///   - flags: Flags that control the execution environment of the work item.
    ///   - work: The closure to run after certain time interval.
    func asyncAfter(delay: Double,
                    qos: DispatchQoS = .unspecified,
                    flags: DispatchWorkItemFlags = [],
                    execute work: @escaping () -> Void) {
        base.asyncAfter(deadline: .now() + delay, qos: qos, flags: flags, execute: work)
    }

    func debounce(delay: Double, action: @escaping () -> Void) -> () -> Void {
        // http://stackoverflow.com/questions/27116684/how-can-i-debounce-a-method-call
        var lastFireTime = DispatchTime.now()
        let deadline = { lastFireTime + delay }
        return {
            base.asyncAfter(deadline: deadline()) {
                let now = DispatchTime.now()
                if now >= deadline() {
                    lastFireTime = now
                    action()
                }
            }
        }
    }
}

#endif

