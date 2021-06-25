//
// Created by Sean Wolford on 4/20/21.
//

import Foundation

enum AlertType {
    case developer
    case userInfo
    case warning
    case error
    case systemInstruction
}

struct Alert: Identifiable {
    var id = UUID()
    var type: AlertType
    var title: String
    var message: String?
    var primaryButtonText: String?
    var primaryAction: (() -> Void)?
    var secondaryButtonText: String?
    var secondaryAction: (() -> Void)?
}
