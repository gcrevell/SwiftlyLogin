//
//  LoginVerfierTests.swift
//  LoginVerfierTests
//
//  Created by Voltmeter Amperage on 7/29/16.
//  Copyright © 2016 Gabriel Revells. All rights reserved.
//

import XCTest
@testable import LoginVerfier

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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        loginManager.email = "wowza7125@icloud.com"
        XCTAssert(try! loginManager.verify(), "Failed to verify the email address wowza7125@icloud.com")
    }
    
    func testInvalidEmail() {
        loginManager.email = "thisIs a badExample @ Hello World.wow"
        do {
            try loginManager.verify()
            XCTFail("Successfully verified the email address \"thisIs a badExample @ Hello World.wow\".This should not have happened.")
        } catch GCRPolicyError.EmailInvalid {
            // Good!
        } catch {
            XCTFail("An unknown exception has occured.")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
