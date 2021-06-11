//
// Created by Sean Wolford on 6/11/21.
//

import Foundation
import SwiftUI

struct ReplacementMenuCommands: Commands {
    var body: some Commands {
        Group {
            CommandGroup(replacing: .appInfo, addition: { })
            CommandGroup(replacing: .appSettings, addition: { })
            CommandGroup(replacing: .appTermination, addition: { })
            CommandGroup(replacing: .appVisibility, addition: { })
            CommandGroup(replacing: .help, addition: { })
            CommandGroup(replacing: .newItem, addition: { })
            CommandGroup(replacing: .pasteboard, addition: { })
            CommandGroup(replacing: .printItem, addition: { })
            CommandGroup(replacing: .saveItem, addition: { })
            CommandGroup(replacing: .sidebar, addition: { })
        }
        Group {
            CommandGroup(replacing: .systemServices, addition: { })
            CommandGroup(replacing: .toolbar, addition: { })
            CommandGroup(replacing: .textEditing, addition: { })
            CommandGroup(replacing: .textFormatting, addition: { })
            CommandGroup(replacing: .undoRedo, addition: { })
            CommandGroup(replacing: .windowArrangement, addition: { })
            CommandGroup(replacing: .windowSize, addition: { })
        }
    }
}
