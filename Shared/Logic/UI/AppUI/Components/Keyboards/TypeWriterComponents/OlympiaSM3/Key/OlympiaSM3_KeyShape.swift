//
//  SmithCoronaSilentKeyShape.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/18/21.
//

import CoreGraphics
import Foundation
import SwiftUI

struct OlympiaSM3KeyShape: Shape {
    func path(in rect: CGRect) -> Path {
        KeyShape.path(in: rect, withSegments: buttonPoints)
    }

    typealias Seg = KeyShape.Segment
    private let buttonPoints: [Seg] = [
        Seg((15.0, 1.25), (00.0, 05.0), (00.0, 02.0), .topLeftCorner),
        Seg((85.0, 1.25), (25.0, 00.0), (75.0, 00.0), .topLine),
        Seg((100, 10.0), (100, 02.0), (100, 05.0), .topRightCorner),
        Seg((88.0, 91.0), (100.0, 55.0), (94.0, 85.0), .rightSide),
        Seg((70.0, 99.0), (85.0, 95.0), (80.0, 99.0), .bottomRightCorner),
        Seg((30.0, 99.0), (55.0, 100), (45.0, 100), .bottomLine),
        Seg((12.0, 91.0), (20.0, 99.0), (15.0, 95.0), .bottomLeftCorner),
        Seg((00.0, 10.0), (06.0, 85.0), (00.0, 55.0), .leftSide),
    ].map({
        let segment = $0
        return KeyShape.Segment(point: segment.point.applying(.init(scaleX: 1/100, y: 1/100)),
                                control1: segment.control1.applying(.init(scaleX: 1/100, y: 1/100)),
                                control2: segment.control2.applying(.init(scaleX: 1/100, y: 1/100)),
                                keySegment: segment.keySegment)
    })
}
