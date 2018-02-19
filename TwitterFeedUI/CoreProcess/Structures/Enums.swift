//
//  Enums.swift
//  ProductCatalog
//
//  Created by Nazario Mariano on 26/10/2017.
//  Copyright © 2017 Nazario Mariano. All rights reserved.
//

import Foundation

enum APIError: Error {
    case noConnectionError
    case otherConnectionError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnectionError:
            return NSLocalizedString("You are not connected to the internet.", comment: "no connection")
        case .otherConnectionError:
            return NSLocalizedString("An error occured when connecting.", comment: "connection error")
        }
    }
}

enum AuthError: Error {
    case failedAuthError
}

extension AuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedAuthError:
            return NSLocalizedString("Login failed.", comment: "failed auth")
        }
    }
}


