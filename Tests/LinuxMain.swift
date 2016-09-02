import XCTest
@testable import SwitchboardTests

XCTMain([
     testCase(PathTests.allTests),
     testCase(PathTypeTests.allTests),
     testCase(RouterTests.allTests),
     testCase(WildcardPathTests.allTests)
])
