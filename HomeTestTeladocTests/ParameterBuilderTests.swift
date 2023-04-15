//
//  ParameterBuilderTests.swift
//  HomeTestTeladocTests
//
//  Created by Moises Apaza on 15/04/2023.
//

import XCTest
@testable import HomeTestTeladoc

final class ParameterBuilderTests: XCTestCase {

    func testTermOfParameters() {
        let term = "thebeatles"
        let parameters = ParametersBuilder(term: term).build()
        XCTAssertEqual(parameters["term"], term)
    }
    
    func testQuantityOfParameters() {
        let parameters = ParametersBuilder(term: "thebeatles").build()
        XCTAssertEqual(parameters.count, 3)
    }
}
