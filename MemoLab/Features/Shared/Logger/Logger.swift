//
//  Logger.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 21/4/25.
//

import Foundation

enum LogLevel: String {
    case error = "❌ MEMOLAB ERROR"
    case warning = "⚠️ MEMOLAB WARNING"
    case info = "ℹ️ MEMOLAB INFO"
    case debug = "🐛 MEMOLAB DEBUG"
}

struct Logger {
    static func log(_ level: LogLevel, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        print("\(level.rawValue): \(message) [\(fileName):\(line) \(function)]")
    }

    static func error(_ message: String) {
        log(.error, message)
    }

    static func warning(_ message: String) {
        log(.warning, message)
    }

    static func info(_ message: String) {
        log(.info, message)
    }

    static func debug(_ message: String) {
        log(.debug, message)
    }
}
