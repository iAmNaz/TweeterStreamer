//
//  Enums.swift
//  ProductCatalog
//
//  Created by Nazario Mariano on 26/10/2017.
//  Copyright © 2017 Nazario Mariano. All rights reserved.
//

import UIKit

public enum AuthError: Error {
    case userNotFound
    case invalidUserPassword
    case failed(String)
}

public enum TaskError: Error {
    case Saving(String)
    case Fetching(String)
}

public enum RequestError: Error {
    case failed(String)
}

public enum HTTPMethod {
    static let GET = "GET"
    static let POST = "POST"
}
