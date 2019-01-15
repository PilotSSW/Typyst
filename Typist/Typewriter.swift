//
//  Typewriter.swift
//  Typist
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import Foundation
import FilesProvider
import SwiftySound

class Typewriter {
    
    var keyUpSounds: [Sound] = []
    var keyDownSounds: [Sound] = []

    init(model: TypewriterModel) {
        // Get root directory and open the corresponding typewriter's folder
        let documentsProvider = LocalFileProvider()
        documentsProvider.contentsOfDirectory(path: "/\(model.rawValue)", completionHandler: { contents, error in
            for file in contents {
                print("Name: \(file.name)")
                print("Size: \(file.size)")
                print("Creation Date: \(file.creationDate)")
                print("Modification Date: \(file.modifiedDate)")
            }
        })
    }
    
    func playSound() {

    }
}
