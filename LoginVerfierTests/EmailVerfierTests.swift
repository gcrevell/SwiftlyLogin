//
//  EmailVerfierTests.swift
//  LoginVerfier
//
//  Created by Voltmeter Amperage on 7/30/16.
//  Copyright © 2016 Gabriel Revells. All rights reserved.
//

import XCTest

class EmailVerfierTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPersonalEmail() {
        XCTAssert(verify(email: "skoobie94@gmail.com"),
                  "Failed to confirm skoobie94@gmail.com as a valid email.")
    }
    
    func testWikipediaExamples() {
        // These examples from from the wikipedia page on email addresses
        // https://en.wikipedia.org/wiki/Email_address
        
        var emailToTest = "prettyandsimple@example.com"
        XCTAssert(verify(email: emailToTest),
                  "Failed to confirm \(emailToTest) as a valid email.")
        
        emailToTest = "very.common@example.com"
        XCTAssert(verify(email: emailToTest),
                  "Failed to confirm \(emailToTest) as a valid email.")
        
        emailToTest = "disposable.style.email.with+symbol@example.com"
        XCTAssert(verify(email: emailToTest),
                  "Failed to confirm \(emailToTest) as a valid email.")
        
        emailToTest = "other.email-with-dash@example.com"
        XCTAssert(verify(email: emailToTest),
                  "Failed to confirm \(emailToTest) as a valid email.")
        
        emailToTest = "x@example.com"
        XCTAssert(verify(email: emailToTest),
                  "Failed to confirm \(emailToTest) as a valid email.")
        
        emailToTest = "example-indeed@strange-example.com"
        XCTAssert(verify(email: emailToTest),
                  "Failed to confirm \(emailToTest) as a valid email.")
    }
    
    func testFailingWikipediaExamples() {
        // Also taken from https://en.wikipedia.org/wiki/Email_address
        
        var emailToTest = "Abc.example.com"
        XCTAssert(!verify(email: emailToTest),
                  "Failed to confirm \(emailToTest) as an invalid email.")
    }
    
}
