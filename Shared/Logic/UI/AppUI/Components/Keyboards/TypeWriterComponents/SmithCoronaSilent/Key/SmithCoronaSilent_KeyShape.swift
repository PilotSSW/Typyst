//
//  SmithCoronaSilent_KeyShape.swift
//  Typyst
//
//  Created by Sean Wolford on 11/23/21.
//

import CoreGraphics
import Foundation
import SwiftUI

struct SmithCoronaSilentKeyShape: Shape {    
    func path(in rect: CGRect) -> Path {
        KeyShape.path(in: rect, withSegments: buttonPoints)
    }
    
    typealias Seg = KeyShape.Segment
    private let buttonPoints: [Seg] = [
        Seg((20.0, 5.0), (00.0, 15.0), (05.0, 10.0), .topLeftCorner),
        Seg((80.0, 5.0), (40.0, 0.0), (60.0, 0.0), .topLine),
        Seg((100, 35.0), (95.0, 10.0), (100.0, 15.0), .topRightCorner),
        Seg((68.0, 96.5), (100.0, 55.0), (94.0, 85.0), .rightSide),
        Seg((58.0, 99.0), (62.0, 98.5), (68.0, 97.25), .bottomRightCorner),
        Seg((42.0, 99.0), (51.0, 100), (49.0, 100), .bottomLine),
        Seg((32.0, 96.5), (32.0, 97.25), (42.0, 99.0), .bottomLeftCorner),
        Seg((00.0, 35.0), (06.0, 85.0), (00.0, 55.0), .leftSide),
    ].map({
        let segment = $0
        return KeyShape.Segment(point: segment.point.applying(.init(scaleX: 1/100, y: 1/100)),
                                control1: segment.control1.applying(.init(scaleX: 1/100, y: 1/100)),
                                control2: segment.control2.applying(.init(scaleX: 1/100, y: 1/100)),
                                keySegment: segment.keySegment)
    })
}
