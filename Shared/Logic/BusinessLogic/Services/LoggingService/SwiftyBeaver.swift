//
//  SwiftyBeaver.swift
//  Typyst
//
//  Created by Sean Wolford on 6/24/21.
//

import Combine
import Foundation
import SwiftyBeaver

class SwiftyBeaverLogger {
    private let appSettings: AppSettings
    private let appDebugSettings: AppDebugSettings

    private var log: SwiftyBeaver.Type? = SwiftyBeaver.self

    init(withStore store: inout Set<AnyCancellable>,
         appSettings: AppSettings = RootDependencyContainer.get().appSettings,
         appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings) {
        self.appSettings = appSettings
        self.appDebugSettings = appDebugSettings

        appSettings.$logErrorsAndCrashes
            .sink { [weak self] isEnabled in
                guard let self = self else { return }
                let log = self.log

                if isEnabled {
                    log?.removeAllDestinations()

                    #if debug
                    let console = ConsoleDestination()
                    console.format = "$DHH:mm:ss$d $L $M"//"$J"
                    log?.addDestination(console)
                    #else
                    let file = FileDestination()
                    log?.addDestination(file)

                    let cloud = SBPlatformDestination(appID: "Rl1RAR",
                                                      appSecret: "przetal0geBkdUwlkomw8n7qP3trpcc0",
                                                      encryptionKey: "zxzlcCmYwNqirvsmaksV88o7nJeNiktq")
                    log?.addDestination(cloud)
                    #endif
                }
                else {
                    log?.removeAllDestinations()
                }
            }
            .store(in: &store)

        appDebugSettings.$debugGlobal
            .sink { [weak self] isEnabled in
                guard let self = self else { return }
                self.log?.destinations.forEach({
                    let destination = $0
                    destination.minLevel = isEnabled
                        ? .verbose
                        : .warning
                })
            }
            .store(in: &store)
    }

    func log(_ level: Logging.Level = .info, _ message: String = "", error: Error? = nil, context: Any? = nil,
             file: String = #file, function: String = #function, line: Int = #line) {
        var logType = level
        if error != nil && (level != .error || level != .fatal) { logType = .error }

        // Don't log stuff beneath warning in production unless user is having an issue
        if !appDebugSettings.debugGlobal && level.rawValue < Logging.Level.warning.rawValue { return }

        if let log = log {
            switch (logType) {
                case .trace:
                    log.verbose(message, file, function, line: line, context: context)
                case .debug:
                    log.debug(message, file, function, line: line, context: context)
                case .info:
                    log.info(message, file, function, line: line, context: context)
                case .warning:
                    log.warning(message, file, function, line: line, context: context)
                case .error, .fatal:
                    log.error(message, file, function, line: line, context: context)
            }
        }
    }
}
