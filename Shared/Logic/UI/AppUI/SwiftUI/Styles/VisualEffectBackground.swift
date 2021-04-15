//
//  VisualEffectBackground.swift
//  Typyst
//
//  Created by Sean Wolford on 3/12/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation
import SwiftUI

struct VisualEffectBackground: NSViewRepresentable {
    private let material: NSVisualEffectView.Material
    private let blendingMode: NSVisualEffectView.BlendingMode
    private let isEmphasized: Bool

    fileprivate init(
        material: NSVisualEffectView.Material,
        blendingMode: NSVisualEffectView.BlendingMode,
        emphasized: Bool) {
        self.material = material
        self.blendingMode = blendingMode
        self.isEmphasized = emphasized
    }

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()

        // Not certain how necessary this is
        view.autoresizingMask = [.width, .height]

        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
        nsView.isEmphasized = isEmphasized
//        nsView.material = context.environment.visualEffectMaterial ?? material
//        nsView.blendingMode = context.environment.visualEffectBlending ?? blendingMode
//        nsView.isEmphasized = context.environment.visualEffectEmphasized ?? isEmphasized
    }
}

extension View {
    func visualEffect(
        material: NSVisualEffectView.Material,
        blendingMode: NSVisualEffectView.BlendingMode = .behindWindow,
        emphasized: Bool = false
    ) -> some View {
        background(
            VisualEffectBackground(
                material: material,
                blendingMode: blendingMode,
                emphasized: emphasized
            )
        )
    }
}


//import SwiftUI
//
//struct VisualEffectView: NSViewRepresentable
//{
//    let material: NSVisualEffectView.Material
//    let blendingMode: NSVisualEffectView.BlendingMode
//
//    func makeNSView(context: Context) -> NSVisualEffectView
//    {
//        let visualEffectView = NSVisualEffectView()
//        visualEffectView.material = material
//        visualEffectView.blendingMode = blendingMode
//        visualEffectView.state = NSVisualEffectView.State.active
//        return visualEffectView
//    }
//
//    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context)
//    {
//        visualEffectView.material = material
//        visualEffectView.blendingMode = blendingMode
//    }
//}
