//
//  SwiftyBeaver.swift
//  Typyst
//
//  Created by Sean Wolford on 6/24/21.
//

import Combine
import Foundation
import GBDeviceInfo
import SwiftyBeaver

final class SwiftyBeaverLogger {
    private let settingsService: SettingsService
    private let appDebugSettings: AppDebugSettings
    private var store: Set<AnyCancellable>

    private var log: SwiftyBeaver.Type? = SwiftyBeaver.self

    /// Mark: Init storing property observers externally for observing elsewhere
    init(withStore store: inout Set<AnyCancellable>,
         settingsService: SettingsService = RootDependencyContainer.get().settingsService,
         appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings) {
        self.settingsService = settingsService
        self.appDebugSettings = appDebugSettings
        self.store = store

        commonInit()
    }

    /// Mark: Init storing property observers internally and deallocating on deinit
    init(settingsService: SettingsService = RootDependencyContainer.get().settingsService,
         appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings) {
        self.settingsService = settingsService
        self.appDebugSettings = appDebugSettings
        self.store = Set<AnyCancellable>()

        commonInit()
    }

    private func commonInit() {
        settingsService.$logErrorsAndCrashes
            .sink { [weak self] isEnabled in
                guard let self = self else { return }
                let log = self.log

                if isEnabled {
                    log?.removeAllDestinations()

                    #if DEBUG
                    let console = ConsoleDestination()
                    console.format = "$DHH:mm:ss$d $L $M"//"$J"
                    log?.addDestination(console)
                    #endif

                    //                    let file = FileDestination()
                    //                    log?.addDestination(file)

                    let cloud = SBPlatformDestination(appID: "Rl1RAR",
                                                      appSecret: "przetal0geBkdUwlkomw8n7qP3trpcc0",
                                                      encryptionKey: "zxzlcCmYwNqirvsmaksV88o7nJeNiktq")
                    log?.addDestination(cloud)
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
        if !appDebugSettings.debugGlobal && level < Logging.Level.warning { return }

        if let log = log {
            var logText = message
            if let error = error {
                logText += """
                    Error: \(error.localizedDescription)
                """
            }

            switch (logType) {
                case .trace:
                    log.verbose(logText, file, function, line: line, context: [context, GBDeviceInfo(), error])
                case .debug:
                    log.debug(logText, file, function, line: line, context: [context, GBDeviceInfo(), error])
                case .info:
                    log.info(logText, file, function, line: line, context: [context, GBDeviceInfo(), error])
                case .warning:
                    log.warning(logText, file, function, line: line, context: [context, GBDeviceInfo(), error])
                case .error, .fatal:
                    log.error(logText, file, function, line: line, context: [context, GBDeviceInfo(), error])
                default:
                    return 
            }
        }
    }
}

extension SwiftyBeaverLogger {
    static func logFatalCrash(_ exception: NSException? = nil) {
        let logger = SwiftyBeaverLogger(settingsService: SettingsService(),
                                        appDebugSettings: AppDebugSettings())
        logger.log(.fatal, "Fatal error captured", error: nil, context: exception)
    }
}
