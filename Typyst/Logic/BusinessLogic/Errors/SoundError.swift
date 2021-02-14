//
// Created by Sean Wolford on 2/6/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation

struct SoundError: Error {
    enum ErrorKind {
        case soundNotFound
        case soundFileMalformed
    }

    let path: String?
    let kind: ErrorKind
}