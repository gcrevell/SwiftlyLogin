//
//  LoginVerfierTests.swift
//  LoginVerfierTests
//
//  Created by Voltmeter Amperage on 7/29/16.
//  Copyright © 2016 Gabriel Revells. All rights reserved.
//

import XCTest
//@testable import GCRSwiftlyLogin

class LoginVerfierTests: XCTestCase {
    
    let loginManager = GCRSwiftlyLogin()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidEmail() {
        loginManager.email = "wowza7125@icloud.com"
        XCTAssert(try! loginManager.verify(), "Failed to verify the email address wowza7125@icloud.com")
    }
    
    func testInvalidEmail() {
        loginManager.email = "thisIs a badExample @ Hello World.wow"
        loginManager.passwordRequirements = .RequireNumber
        
        do {
            try loginManager.verify()
            XCTFail("Successfully verified the email address \"thisIs a badExample @ Hello World.wow\".This should not have happened.")
        } catch GCRPolicyError.emailInvalid {
            // Good!
        } catch {
            XCTFail("An unknown exception has occured.")
        }
    }
    
    func testInvalidPasswordNumbers() {
        loginManager.password = "passwordOne@?***"
        loginManager.passwordRequirements = .RequireNumber
        
        do {
            try loginManager.verify()
            XCTFail("Successfully verified the password \"passwordOne@?***\".This should not have happened.")
        } catch GCRPolicyError.omitsNumbers {
            // Good!
        } catch {
            XCTFail("An unknown exception has occured.")
        }
    }
    
    func testValidPasswordNumbers() {
        loginManager.password = "password1234"
        XCTAssert(try! loginManager.verify(), "Failed to verify the password 'password1'")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
