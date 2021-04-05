//
// Created by Sean Wolford on 4/5/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import FirebaseCore
import FirebaseCoreDiagnostics
import FirebaseCrashlytics
import FirebaseInstallations
import Foundation

class FireBaseWrapper {

    func setup() {
        AppSettings.shared.$logErrorsAndCrashes
            .sink { isEnabled in
                if isEnabled {
                    FirebaseApp.configure()
                }
                else {
                    FirebaseApp.app()?.delete({ result in
                        print(result)
                    })
                }
            }
            .store(in: &App.instance.subscriptions)
    }
}