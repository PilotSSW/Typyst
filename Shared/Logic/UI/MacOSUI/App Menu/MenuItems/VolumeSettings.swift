////
//// Created by Sean Wolford on 2/15/21.
//// Copyright (c) 2021 wickedPropeller. All rights reserved.
////
//
//import AppKit
//import Combine
//import Foundation
//
//class MenuItemsVolumeSettings {
//    var items: [NSMenuItem] {[
//        sectionHeader,
//        volumeSlider,
//        NSMenuItem.separator()
//    ]}
//
//    lazy private var sectionHeader: NSMenuItem = {
//        let volumeItem = NSMenuItem(title: "Volume", action: nil, keyEquivalent: "")
//        volumeItem.isEnabled = false
//        volumeItem.tag = 2
//
//        volumeItem.view?.frame = NSRect(origin: .zero, size: CGSize(width: 450, height: 24))
//
//        return volumeItem
//    }()
//
//    lazy private var slider: NSView = {
//        let slider = NSSlider(frame: NSRect(origin: CGPoint(x: 25, y: 0), size: CGSize(width: 450, height: 24)))
//
//        slider.action = #selector(setVolume(slider:))
//        slider.target = self
//        slider.doubleValue = AppDependencyContainer.get().appSettings.volumeSetting
//        slider.isEnabled = AppDelegate.isAccessibilityAdded()
//
//        AppDependencyContainer.get().appSettings.$volumeSetting
//            .sink { slider.doubleValue = $0 }
//            .store(in: &AppCore.instance.subscriptions)
//
//        return slider
//    }()
//
//    lazy private var sliderComponent: NSView = {
//        let sliderView = NSView(frame: NSRect(x: 0, y: 0, width: 500, height: 24))
//        sliderView.addSubview(slider)
//
//        return sliderView
//    }()
//
//    lazy private var volumeSlider: NSMenuItem = {
//        let volumeItem = NSMenuItem()
//        volumeItem.view = sliderComponent
//
//        return volumeItem
//    }()
//
//    @objc func setVolume(slider: NSSlider) {
//        AppCore.instance.typeWriterHandler.setVolumeTo(slider.doubleValue)
//    }
//}
