//
//  KeyShape.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/21/21.
//

import CoreGraphics
import Foundation
import SwiftUI

struct KeyShape {
    private static let defaultInset: CGFloat = 0.0

    static func path(in rect: CGRect, withSegments segments: [Segment]) -> Path {
        Path { path in
            let scaledSegments = scaleSegmentsForCGRect(segments.sorted(by: { $0.keySegment.rawValue < $1.keySegment.rawValue }),
                                                        width: rect.width,
                                                        height: rect.height)

            for (index, segment) in scaledSegments.enumerated() {
                if index == 0 {
                    path.move(to: segment.point)
                }
                else {
                    path.addCurve(to: segment.point,
                                  control1: segment.control1,
                                  control2: segment.control2)
                }
            }

            if let first = scaledSegments.first {
                path.addCurve(to: first.point,
                              control1: first.control1,
                              control2: first.control2)
            }
        }
    }

    enum KeySegment: Int {
        // Corners
        case topLeftCorner = 0
        case topRightCorner = 2
        case bottomLeftCorner = 6
        case bottomRightCorner = 4
        // Vertical
        case topLine = 1
        case bottomLine = 5
        // Horizontal
        case leftSide = 7
        case rightSide = 3
    }

    struct Segment {
        let point: CGPoint
        let control1: CGPoint
        let control2: CGPoint
        let keySegment: KeySegment

        init(point: CGPoint, control1: CGPoint, control2: CGPoint, keySegment: KeySegment) {
            self.point = point
            self.control1 = control1
            self.control2 = control2
            self.keySegment = keySegment
        }

        init(_ point: (Double, Double), _ control1: (Double, Double), _ control2: (Double, Double), _ keySegment: KeySegment) {
            self.point = CGPoint(x: point.0, y: point.1)
            self.control1 = CGPoint(x: control1.0, y: control1.1)
            self.control2 = CGPoint(x: control2.0, y: control2.1)
            self.keySegment = keySegment
        }
    }

    private static func scaleSegmentsForCGRect(_ segment: [Segment], width: CGFloat, height: CGFloat) -> [Segment] {
        segment.map({
            let segmentValue = $0
            let point = segmentValue.point
            let control1 = segmentValue.control1
            let control2 = segmentValue.control2
            let keySegment = segmentValue.keySegment

            return Segment(point: CGPoint(x: point.x * width,
                                          y: point.y * height),
                           control1: CGPoint(x: control1.x * width,
                                             y: control1.y * height),
                           control2: CGPoint(x: control2.x * width,
                                             y: control2.y * height),
                           keySegment: keySegment)
        })
    }
}
