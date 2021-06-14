//
// Created by Sean Wolford on 4/5/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//
import Combine
import Foundation
import SwiftyBeaver
import SwiftUI

class Logging {
    private var log: SwiftyBeaver.Type? = SwiftyBeaver.self

    enum Level: Int {
        case trace = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        case fatal = 5
    }

    func setup(withStore store: inout Set<AnyCancellable>) {
        appDependencyContainer.appSettings.$logErrorsAndCrashes
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

        appDependencyContainer.appDebugSettings.$debugGlobal
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

    func log(_ level: Level = .info, _ message: String = "", error: Error? = nil, context: Any? = nil,
             file: String = #file, function: String = #function, line: Int = #line) {
        var logType = level
        if error != nil && (level != .error || level != .fatal) { logType = .error }

        // Don't log stuff beneath warning in production unless user is having an issue
        if !appDependencyContainer.appDebugSettings.debugGlobal && level.rawValue < Level.warning.rawValue { return }

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

protocol Loggable {}
extension Loggable {
    func logEvent(_ level: Logging.Level = .info, _ message: String = "", error: Error? = nil, context: Any? = nil,
                  file: String = #file, function: String = #function, line: Int = #line,
                  loggerInstance: Logging = appDependencyContainer.logging) {
        loggerInstance.log(level, message, error: error, context: context, file: file, function: function, line: line)
    }
}
