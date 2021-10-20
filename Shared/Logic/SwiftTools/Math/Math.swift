//
//  Math.swift
//  Typyst
//
//  Created by Sean Wolford on 10/20/21.
//

import Foundation

class Math {
    public static func slopeInterceptFromTwoPoints(x1: Double, y1: Double, x2: Double, y2: Double) -> (slope: Double, intercept: Double) {
        let slope = (y2 - y1) / (x2 - x1)
        let intercept = y2 - (slope * x2)
        return (slope, intercept)
    }
    
    public static func currentPositionUsing(scalar: Double, offset: Double, input: Double) -> Double {
        scalar * input + offset
    }
}
