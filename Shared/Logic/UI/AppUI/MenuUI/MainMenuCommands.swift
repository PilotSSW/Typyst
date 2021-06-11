//
//  MainMenuCommands.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 6/11/21.
//

import Foundation
import SwiftUI

struct MainMenuCommands: Commands {
    var body: some Commands {
        CommandMenu("Typyst") {            
            AppSettingsCommands()
        }
    }
}
