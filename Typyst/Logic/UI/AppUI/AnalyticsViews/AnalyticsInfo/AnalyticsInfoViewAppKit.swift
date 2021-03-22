//
// Created by Sean Wolford on 3/19/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

//import AppKit
//import Cocoa
//import Foundation
//
//class AnalyticsInfoView {
//    let viewModel = AnalyticsInfoViewModel()
//    let view = NSStackView(frame: CGRect(x: 0, y: 0, width: 500, height: 350))
//
//    init() {
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.alignment = .left
//        view.distribution = .fill
//        view.spacing = 8
//        setupView()
//    }
//
//    func setupView() {
//
//        // Create rows of text
//        for item in viewModel.analyticsItems {
//            let analyticsLabel = NSTextField(string: formatTextForRowWith(seconds: item.amountOfTime,
//                    totalKP: item.totalKeyPresses, averageKP: item.averageKeyPresses))
//            analyticsLabel.font = NSMenu().font
//            analyticsLabel.isBezeled = false
//            analyticsLabel.isBordered = false
//            analyticsLabel.isEditable = false
//            analyticsLabel.isSelectable = false
//            analyticsLabel.backgroundColor = .clear
//            analyticsLabel.textColor = .white
//            view.addArrangedSubview(analyticsLabel)
//        }
//
//        // Update text when the view model updates a row
//        viewModel.analyticsItemsUpdated = { [weak self, weak viewModel] (index) in
//            guard let self = self else { return }
//
//            if let analyticsItem = self.viewModel.analyticsItems[safe: index] {
//                DispatchQueue.main.async(execute: {
//                    if let textView = self.view.arrangedSubviews[safe: index] as? NSTextField,
//                       let textForRow = viewModel?.formatTextForRowWith(seconds: analyticsItem.amountOfTime,
//                                                                                totalKP: analyticsItem.totalKeyPresses,
//                                                                                averageKP: analyticsItem.averageKeyPresses) {
//                        textView.stringValue = textForRow
//                    }
//                })
//            }
//        }
//    }
//}


