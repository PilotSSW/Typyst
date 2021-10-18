//
// Created by Sean Wolford on 4/5/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//
import Combine
import Foundation

final class Logging {
    private let settingsService: SettingsService
    private let appDebugSettings: AppDebugSettings

    private let swiftyBeaverLogger: SwiftyBeaverLogger

    enum Level: Int, Comparable {
        static func < (lhs: Logging.Level, rhs: Logging.Level) -> Bool {
            lhs.rawValue < rhs.rawValue
        }

        case trace = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        case fatal = 5
    }

    init(withStore store: inout Set<AnyCancellable>,
         settingsService: SettingsService = RootDependencyContainer.get().settingsService,
         appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings) {
        self.settingsService = settingsService
        self.appDebugSettings = appDebugSettings
        
        swiftyBeaverLogger = SwiftyBeaverLogger(
            withStore: &store,
            settingsService: settingsService,
            appDebugSettings: appDebugSettings)
    }

    /// This function should only be used from Loggable protocol and something other than default logger instance is needeed,
    /// the caller needs to get and hold on to reference.
    fileprivate func log(_ level: Level = .info, _ message: String = "", error: Error? = nil, context: Any? = nil,
             file: String = #file, function: String = #function, line: Int = #line) {
        swiftyBeaverLogger.log(level, message, error: error, context: context, file: file, function: function, line: line)
    }

    static func logFatalCrash(_ exception: NSException? = nil) {
        SwiftyBeaverLogger.logFatalCrash(exception)
    }
    
    static func log(inInstance loggingInstance: Logging, _ level: Level = .info, _ message: String = "", error: Error? = nil, context: Any? = nil,
             file: String = #file, function: String = #function, line: Int = #line) {
        loggingInstance.log(level, message, error: error, context: context, file: file, function: function, line: line)
    }
}

protocol Loggable {}
extension Loggable {
    func logEvent(_ level: Logging.Level = .info, _ message: String = "", error: Error? = nil, context: Any? = nil,
                  file: String = #file, function: String = #function, line: Int = #line,
                  loggerInstance: Logging = RootDependencyContainer.get().logging) {
        DispatchQueue.global(qos: .utility).async {
            loggerInstance.log(level, message, error: error, context: context, file: file, function: function, line: line)
        }
    }
}
