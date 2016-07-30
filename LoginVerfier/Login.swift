//
//  Login.swift
//  LoginVerfier
//
//  Created by Voltmeter Amperage on 7/29/16.
//  Copyright © 2016 Gabriel Revells. All rights reserved.
//

import Foundation

struct GCRPolicy: OptionSet {
    let rawValue : UInt32
    
    static let RequireUpperAndLowerCase   = GCRPolicy(rawValue: 1 << 0)
    static let RequireNumber              = GCRPolicy(rawValue: 1 << 1)
    static let ForbidNumber               = GCRPolicy(rawValue: 1 << 2)
    static let RequireSpecialCharacter    = GCRPolicy(rawValue: 1 << 3)
    static let ForbidSpecialCharacter     = GCRPolicy(rawValue: 1 << 4)
    static let RequireLength8             = GCRPolicy(rawValue: 1 << 5)
    static let RequireLength12            = GCRPolicy(rawValue: 1 << 6)
    static let RequireEmoji               = GCRPolicy(rawValue: 1 << 7)
    static let ForbidEmoji                = GCRPolicy(rawValue: 1 << 8)
}

class GCRLogin {
    
    private let passwordRequirements: GCRPolicy
    
    init() {
        passwordRequirements = []
    }
}
