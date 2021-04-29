//
// Created by Sean Wolford on 4/20/21.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title = Text("")
    var message: Text?
    var dismissButton: SwiftUI.Alert.Button?
    var primaryButton: SwiftUI.Alert.Button?
    var secondaryButton: SwiftUI.Alert.Button?
}

