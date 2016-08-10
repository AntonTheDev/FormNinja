//
//  FormNinja_ValidationTests.swift
//  FormNinja-ValidationTests
//
//  Created by Anton on 8/9/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import XCTest

class FormNinja_ValidationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFirstNameValidator() {
        let v = Validator(type: .firstName)
        
        // First Name Should At Least have 3 character
        XCTAssertEqual(v.validate("A"),       false, "First Name Validation Failed")
        XCTAssertEqual(v.validate("An"),      false, "First Name Validation Failed")
        XCTAssertEqual(v.validate("Ant"),     true,  "First Name Validation Failed")
        XCTAssertEqual(v.validate("Anto"),    true,  "First Name Validation Failed")
        XCTAssertEqual(v.validate("Anton"),   true,  "First Name Validation Failed")
       
        // First Name Should not have 2 words
        XCTAssertEqual(v.validate("Anton Doudarev"),  false, "First Name Validation Failed")
        
        // First Name Should not have heading or trailing space
        XCTAssertEqual(v.validate(" Anton"),  false, "First Name Validation Failed")
        XCTAssertEqual(v.validate("Anton "),  false, "First Name Validation Failed")
    }
    
    func testLastNameValidator() {
        let v = Validator(type: .lastName)
        
        // Last Name Should At Least have 3 character
        XCTAssertEqual(v.validate("D"),            false, "Last Name Validation Failed")
        XCTAssertEqual(v.validate("Do"),           false, "Last Name Validation Failed")
        XCTAssertEqual(v.validate("Dou"),          true,  "Last Name Validation Failed")
        XCTAssertEqual(v.validate("Doud"),         true,  "Last Name Validation Failed")
        XCTAssertEqual(v.validate("Doudarev"),     true,  "Last Name Validation Failed")
        
        // Last Name Should not have 2 words
        XCTAssertEqual(v.validate("Anton Doudarev"),  false, "Last Name Validation Failed")
        
        // Last Name Should not have heading or trailing space
        XCTAssertEqual(v.validate(" Doudarev"),  false, "Last Name Validation Failed")
        XCTAssertEqual(v.validate("Doudarev "),  false, "Last Name Validation Failed")
    }

}
