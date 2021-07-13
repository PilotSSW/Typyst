//
//  UIKitExtensions.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import Foundation
import UIKit

extension UIViewController {
    func addAndContainChildVC(_ viewController: UIViewController) {
        addChild(viewController)
        viewController.view.frame = self.view.frame
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
