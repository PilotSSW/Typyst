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
                path.closeSubpath()
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
        
        func isLeft() -> Bool {
            [.topLeftCorner, .leftSide, .bottomLeftCorner].contains(self)
        }
        
        func isRight() -> Bool {
            [.topRightCorner, .rightSide, .bottomRightCorner].contains(self)
        }
        
        func isTop() -> Bool {
            [.topLeftCorner, .topLine, .topRightCorner].contains(self)
        }
        
        func isBottom() -> Bool {
            [.bottomLeftCorner, .bottomLine, .bottomRightCorner].contains(self)
        }
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
        segment.map({ scaleSegmentForViewSize($0, width: width, height: height) })
    }
    
    private static func scaleSegmentForViewSize(_ segmentValue: Segment, width: CGFloat, height: CGFloat) -> Segment {
        let point = segmentValue.point
        let control1 = segmentValue.control1
        let control2 = segmentValue.control2
        let keySegment = segmentValue.keySegment
        
        return Segment(point: scalePoint(x: point.x, y: point.y, width: width, height: height, keySegment: keySegment),
                       control1: scalePoint(x: control1.x, y: control1.y, width: width, height: height, keySegment: keySegment, pointType: .control1),
                       control2: scalePoint(x: control2.x, y: control2.y, width: width, height: height, keySegment: keySegment, pointType: .control2),
                       keySegment: keySegment)
    }
    
    private enum PointType {
        case point
        case control1
        case control2
    }
    
    private static func scalePoint(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, keySegment: KeySegment, pointType: PointType = .point) -> CGPoint {
        var scaledX: CGFloat = 0.0
        var scaledY: CGFloat = 0.0
        
        let aspectRatio = width / height
        
        if([.topLeftCorner].contains(keySegment)) {
            scaledX = width * (x - calculateOffset(position: x, aspectRatio: aspectRatio, isRightOrBottom: false))
            scaledY = height * (y - calculateOffset(position: y, aspectRatio: aspectRatio, isRightOrBottom: false))
        }
        else if([.topLine].contains(keySegment)) {
            scaledX = (x + calculateOffset(position: x, aspectRatio: aspectRatio, isRightOrBottom: [.point, .control2].contains(pointType))) * width
            scaledY = (y - calculateOffset(position: y, aspectRatio: aspectRatio, isRightOrBottom: false)) * height
        }
        else if([.topRightCorner].contains(keySegment)) {
            scaledX = (x + calculateOffset(position: x, aspectRatio: aspectRatio, isRightOrBottom: true)) * width
            scaledY = (y - calculateOffset(position: y, aspectRatio: aspectRatio, isRightOrBottom: false)) * height
        }
        else if([.rightSide, .bottomRightCorner].contains(keySegment)) {
            scaledX = (x + calculateOffset(position: x, aspectRatio: aspectRatio, isRightOrBottom: true)) * width
            scaledY = (y + calculateOffset(position: y, aspectRatio: aspectRatio, isRightOrBottom: true)) * height
        }
        else if([.bottomLine].contains(keySegment)) {
            scaledX = (x - calculateOffset(position: x, aspectRatio: aspectRatio, isRightOrBottom: [.control1].contains(pointType))) * width
            scaledY = (y + calculateOffset(position: y, aspectRatio: aspectRatio, isRightOrBottom: true)) * height
        }
        else if([.bottomLeftCorner].contains(keySegment)) {
            scaledX = (x - calculateOffset(position: x, aspectRatio: aspectRatio, isRightOrBottom: false)) * width
            scaledY = (y + calculateOffset(position: y, aspectRatio: aspectRatio, isRightOrBottom: true)) * height
        }
        else if([.leftSide].contains(keySegment)) {
            scaledX = width * (x - calculateOffset(position: x, aspectRatio: aspectRatio, isRightOrBottom: false))
            scaledY = height * (y - calculateOffset(position: y, aspectRatio: aspectRatio, isRightOrBottom: [.control1, .control2].contains(pointType)))
        }
        
        return CGPoint(x: scaledX, y: scaledY)
    }
    
    private static func calculateOffset(position: CGFloat, aspectRatio: CGFloat, isRightOrBottom: Bool) -> CGFloat {
        isRightOrBottom
            ? (1 - position) * ((aspectRatio - 1) / (aspectRatio))
            : position * ((aspectRatio - 1) / (aspectRatio))
    }
}
