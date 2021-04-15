//
// Created by Sean Wolford on 2/19/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation

func systemUptime() -> TimeInterval {
    var currentTime = time_t()
    var bootTime    = timeval()
    var mib         = [CTL_KERN, KERN_BOOTTIME]
    // NOTE: Use strideof(), NOT sizeof() to account for data structure
    // alignment (padding)
    // http://stackoverflow.com/a/27640066
    // https://devforums.apple.com/message/1086617#1086617
    var size = MemoryLayout<timeval>.stride
    let result = sysctl(&mib, u_int(mib.count), &bootTime, &size, nil, 0)
    if result != 0 {
        #if DEBUG
        NSLog("ERROR - \(#file):\(#function) - errno = \(result)")
        #endif
        return 0
    }
    // Since we don't need anything more than second level accuracy, we use
    // time() rather than say gettimeofday(), or something else. uptime
    // command does the same
    time(&currentTime)
    let uptime = currentTime - bootTime.tv_sec

    return TimeInterval(uptime)
}