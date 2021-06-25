//
// Created by Sean Wolford on 4/5/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//
import Combine
import Foundation

class Logging {
    private let appSettings: AppSettings
    private let appDebugSettings: AppDebugSettings

    private let swiftyBeaverLogger: SwiftyBeaverLogger

    enum Level: Int {
        case trace = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        case fatal = 5
    }

    init(withStore store: inout Set<AnyCancellable>,
         appSettings: AppSettings = RootDependencyContainer.get().appSettings,
         appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings) {
        self.appSettings = appSettings
        self.appDebugSettings = appDebugSettings
        
        swiftyBeaverLogger = SwiftyBeaverLogger(
            withStore: &store,
            appSettings: appSettings,
            appDebugSettings: appDebugSettings)
    }

    func log(_ level: Level = .info, _ message: String = "", error: Error? = nil, context: Any? = nil,
             file: String = #file, function: String = #function, line: Int = #line) {

        swiftyBeaverLogger.log(level, message, error: error, context: context, file: file, function: function, line: line)
    }
}

protocol Loggable {}
extension Loggable {
    func logEvent(_ level: Logging.Level = .info, _ message: String = "", error: Error? = nil, context: Any? = nil,
                  file: String = #file, function: String = #function, line: Int = #line,
                  loggerInstance: Logging = RootDependencyContainer.get().logging) {
        loggerInstance.log(level, message, error: error, context: context, file: file, function: function, line: line)
    }
}
