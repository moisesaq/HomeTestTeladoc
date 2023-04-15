//
//  AppError.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 14/04/2023.
//

import Foundation

enum AppError: Error {
    case networkError
    case customError(message: String)
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Not internet connection!"
        case .customError(let message):
            return message
        }
    }
}
