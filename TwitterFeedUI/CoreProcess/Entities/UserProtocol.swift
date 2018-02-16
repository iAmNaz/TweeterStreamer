//
//  UserProtocol.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol UserProtocol {
    var screenName:String { get set }
    func authorized() -> Bool
}
