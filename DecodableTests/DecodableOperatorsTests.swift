//
//  DecodableOperatorsTests.swift
//  Decodable
//
//  Created by FJBelchi on 13/07/15.
//  Copyright © 2015 anviking. All rights reserved.
//

import XCTest
@testable import Decodable

class DecodableOperatorsTests: XCTestCase {

    // MARK: =>
    
    func testDecodeAnyDecodableSuccess() {
        // given
        let key = "key"
        let value = "value"
        let dictionary: NSDictionary = [key: value]
        // when
        let string = try! dictionary => key as String
        // then
        XCTAssertEqual(string, value)
    }
    
    func testDecodeAnyDecodableDictionarySuccess() {
        // given
        let key = "key"
        let value: NSDictionary = [key : "value"]
        let dictionary: NSDictionary = [key: value]
        // when
        let result = try! dictionary => key
        // then
        XCTAssertEqual(result, value)
    }
    
    func testDecodeAnyDecodableOptionalSuccess() {
        // given
        let key = "key"
        let value = "value"
        let dictionary: NSDictionary = [key: value]
        // when
        let string = try! dictionary => key as String?
        // then
        XCTAssertEqual(string!, value)
    }
    
    func testDecodeAnyDecodableOptionalNilSuccess() {
        // given
        let key = "key"
        let dictionary: NSDictionary = [key: NSNull()]
        // when
        let string = try! dictionary => key as String?
        // then
        XCTAssertNil(string)
    }
    
    func testDecodeAnyDecodableArraySuccess() {
        // given
        let key = "key"
        let value: NSArray = ["value1", "value2", "value3"]
        let dictionary: NSDictionary = [key: value]
        // when
        let result = try! dictionary => key as Array<String>
        // then
        XCTAssertEqual(result, value)
    }
    
    // MARK: => Errors
    
    func testDecodeAnyDecodableThrowMissingKeyException() {
        // given
        let key = "key"
        let value = "value"
        let dictionary: NSDictionary = [key: value]
        // when
        do {
            try dictionary => "nokey" as String
        } catch DecodingError.MissingKey(let key, _) {
            // then
            XCTAssertEqual(key, "nokey")
        } catch {
            XCTFail("should not throw this exception")
        }
    }
    
    func testDecodeAnyDecodableThrowNoJsonObjectException() {
        // given
        let key = "key"
        let noDictionary: NSString = "hello"
        // when
        do {
            try noDictionary => key as String
        } catch DecodingError.JSONNotObject {
            // then
            XCTAssertTrue(true)
        } catch {
            XCTFail("should not throw this exception")
        }
    }
    
    func testDecodeAnyDecodableDictionaryThrowMissingKeyException() {
        // given
        let key = "key"
        let value: NSDictionary = [key : "value"]
        let dictionary: NSDictionary = [key: value]
        // when
        do {
            try dictionary => "nokey"
        } catch DecodingError.MissingKey(let key, _) {
            // then
            XCTAssertEqual(key, "nokey")
        } catch {
            XCTFail("should not throw this exception")
        }
    }
    
    func testDecodeAnyDecodableDictionaryThrowJSONNotObjectException() {
        // given
        let key = "key"
        let noDictionary: NSString = "noDictionary"
        // when
        do {
            try noDictionary => key
        } catch DecodingError.JSONNotObject {
            // then
            XCTAssertTrue(true)
        } catch {
            XCTFail("should not throw this exception")
        }
    }
    
    func testDecodeAnyDecodableDictionaryThrowTypeMismatchException() {
        // given
        let key = "key"
        let dictionary: NSDictionary = [key: "value"]
        // when
        do {
            try dictionary => key
        } catch DecodingError.TypeMismatch {
            // then
            XCTAssertTrue(true)
        } catch {
            XCTFail("should not throw this exception")
        }
    }
}