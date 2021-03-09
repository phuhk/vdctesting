//
//  XCTestCaseExtension.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import XCTest
@testable import OpenWeatherClient

extension XCTestCase {
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil
        
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            
            FatalErrorUtil.restoreFatalError()
        }
    }
    
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}

struct FatalErrorUtil {
    
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}

func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}
