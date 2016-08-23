//
//  Login.swift
//  LoginVerfier
//
//  Created by Voltmeter Amperage on 7/29/16.
//  Copyright © 2016 Gabriel Revells. All rights reserved.
//

import Foundation

/**
 The policies used to verify passwords or other strings.
 
 GCRPolicy is a set of values that defines what format is required
 for a string. Used with the GCRLogin class, this defines what
 is forced or restricted for a string to contain in order for that
 string to be considered valid.
 
 Defined values include:
 - RequireUpperAndLowerCase
 - RequireNumber
 - ForbidNumber
 - RequireSpecialNumber
 - ForbidSpecialNumber
 - RequireLength8
 - RequireLength12
 - RequireEmoji
 - ForbidEmoji
 
 GCRPolicy also defines preset values, sufficent for password
 strength.
 
 Defined presets, and what they define, include:
 - MediumStrength
    - RequireNumber
    - RequireLength8
 - HighStrength
    - RequireUpperAndLowerCase
    - RequireNumber
    - RequireSpecialCharacter
    - RequireLength12
*/
struct GCRPolicy: OptionSet {
    let rawValue : UInt32
    
    /// Require the use of capital and lower case letters.
    static let RequireUpperAndLowerCase = GCRPolicy(rawValue: 1 << 0)
    
    /// Require the use of a number in the string.
    static let RequireNumber            = GCRPolicy(rawValue: 1 << 1)
    
    /// Forbid the use of a number within the string.
    static let ForbidNumber             = GCRPolicy(rawValue: 1 << 2)
    
    /// Require the use of a special character: **!@#$%^&*()-+=<>[]{}**
    static let RequireSpecialCharacter  = GCRPolicy(rawValue: 1 << 3)
    
    /// Forbid the use of any special characters: **!@#$%^&*()-+=<>[]{}**
    static let ForbidSpecialCharacter   = GCRPolicy(rawValue: 1 << 4)
    
    /// Require the use of a string of length 8 or greater.
    static let RequireLength8           = GCRPolicy(rawValue: 1 << 5)
    
    /// Require the use of a string of length 12 or greater.
    static let RequireLength12          = GCRPolicy(rawValue: 1 << 6)
    
    /// Require the string contains an emoji character.
//    static let RequireEmoji             = GCRPolicy(rawValue: 1 << 7)
    
    /// Forbid the string from containing an emoji character.
//    static let ForbidEmoji              = GCRPolicy(rawValue: 1 << 8)
    
    
    /**
     A combination of policies, equalivent to [RequireNumber, RequireLength8]
     
     Medium Strength defines a set of policies for a medium strength password
     or other string. It requires the use of
        - A number
        - A length of 8 characters
     
     This may be combined with any other GCRPolicy, so long as they don't
     conflict with the existing policies.
    */
    static let MediumStrength: GCRPolicy    = [.RequireNumber,
                                               .RequireLength8]
    
    /**
     A combination of policies, sufficient to provide a high strength password
     
     High Strength defines a set of policies for a high strength password
     or other string. It requires the use of
     - Upper and lower case letters
     - A number
     - A special character **!@#$%^&*()-+=<>[]{}**
     - A length of 12 characters
     
     This may be combined with any other GCRPolicy, so long as they don't
     conflict with the existing policies.
     */
    static let HighStrength: GCRPolicy      = [.RequireUpperAndLowerCase,
                                               .RequireNumber,
                                               .RequireSpecialCharacter,
                                               .RequireLength12]
}

enum GCRPolicyError: Error {
    case omitsUpperCaseLetters
    case omitsLowerCaseLetters
    case omitsNumbers
    case containsNumbers
    case omitsSpecialCharacters
    case containsSpecialCharacters
    case tooShort
//    case omitsEmojis
//    case containsEmojis
    
    case emailInvalid
}

/**
 SwiftlyLogin class. Stores the values for loggin into an account and
 can verify them with specified policies.
 
 SwiftlyLogin is a small helper class to make securing apps with accounts 
 easier. SwiftlyLogin provides support for verfiying emails, usernames, 
 passwords, or any other strings. It has built in options for requirements, 
 allowing the developer to define what is a legal password, then the class 
 takes care of all the checking.
 
 - version: 0B
 
 - todo: 
    - Allow storing usernames/emails/passwords
    - Verify stored values
    - Allow policy changes
    - Hash passwords
    - Store passwords/Usernames with Keychain
 
 - author: Gabriel Revells
 
 - copyright: MIT License (c) Gabriel Revells 2016
 */
class GCRSwiftlyLogin {
    
    fileprivate var _passwordRequirements: GCRPolicy = []
    var passwordRequirements: GCRPolicy {
        set (newVal) {
            var value = newVal
            
            if value.contains(.RequireNumber) && value.contains(.ForbidNumber) {
                value.remove(.ForbidNumber)
            }
            
            if value.contains(.RequireLength8) && value.contains(.RequireLength12) {
                value.remove(.RequireLength8)
            }
            
            _passwordRequirements = value
        }
        
        get {
            return _passwordRequirements
        }
    }
    
    fileprivate var _password: String?
    var password: String? {
        set (newVal) {
            _password = newVal
        }
        
        get {
            return _password
        }
    }
    
    fileprivate var _email: String?
    var email: String? {
        set (newVal) {
            _email = newVal
        }
        
        get {
            return _password
        }
    }
    
    func verify() throws -> Bool {
        if _email != nil && !GCRSwiftlyLogin.verify(_email!) {
            throw GCRPolicyError.emailInvalid
        }
        
        if let password = self.password {
            if self.passwordRequirements.contains(.RequireUpperAndLowerCase) {
                // Password requirements require upper and lower case letters
                if password.uppercased() == password {
                    // Password is same with all upper case (no lower case)
                    throw GCRPolicyError.omitsLowerCaseLetters
                }
                
                if password.lowercased() == password {
                    // Password is same with all lower case (no upper case)
                    throw GCRPolicyError.omitsUpperCaseLetters
                }
            }
            
            if self.passwordRequirements.contains(.RequireNumber) {
                if password.rangeOfCharacter(from: .decimalDigits) == nil {
                    throw GCRPolicyError.omitsNumbers
                }
            }
            
            if self.passwordRequirements.contains(.ForbidNumber) {
                if password.rangeOfCharacter(from: .decimalDigits) != nil {
                    throw GCRPolicyError.containsNumbers
                }
            }
            
            if self.passwordRequirements.contains(.RequireSpecialCharacter) {
                if password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{};':,./<>?")) == nil {
                    throw GCRPolicyError.omitsSpecialCharacters
                }
            }
            
            if self.passwordRequirements.contains(.ForbidSpecialCharacter) {
                if password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{};':,./<>?")) != nil {
                    throw GCRPolicyError.containsSpecialCharacters
                }
            }
            
            if self.passwordRequirements.contains(.RequireLength8) {
                if password.characters.count < 8 {
                    throw GCRPolicyError.tooShort
                }
            }
            
            if self.passwordRequirements.contains(.RequireLength12) {
                if password.characters.count < 12 {
                    throw GCRPolicyError.tooShort
                }
            }
        }
        
        return true
    }
    
    func saveToKeychain() {
        let KC = KeychainWrapper()
        KC.mySetObject(password, forKey: "GCRPassword")
        KC.mySetObject(email, forKey: "GCREmail")
        
        KC.writeToKeychain()
    }
    
    func loadFromKeychain() {
        let KC = KeychainWrapper()
        password = KC.myObject(forKey: "GCRPassword") as? String
        email = KC.myObject(forKey: "GCREmail") as? String
    }
    
    /**
     Verify an email address stored as a string.
     
     This function uses a simple RegEx to verify if an entered email address
     is a valid email address.
     
     The RegEx pattern for this function was used from http://emailregex.com
     
     - parameter email: String, the email address to check for validity.
     
     - returns: Bool, true if the string contains exactly one email address,
     false otherwise.
     */
    static func verify(_ email: String) -> Bool {
        // This line used from http://emailregex.com
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
        let regEx = try! NSRegularExpression(pattern: emailRegex, options: [])
        
        return regEx.numberOfMatches(in: email, options: [], range: NSRange(location: 0, length: email.characters.count)) == 1
    }
}
