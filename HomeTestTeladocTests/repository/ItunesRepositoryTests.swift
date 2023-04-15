//
//  ItunesRepositoryTests.swift
//  HomeTestTeladocTests
//
//  Created by Moises Apaza on 15/04/2023.
//

import RxBlocking
import RxSwift
import XCTest

final class ItunesRepositoryTests: XCTestCase {

    func testWhenItunesRepositoryReturnsAlbums() throws {
        let repository = MockItunesRepository()
        XCTAssertEqual(try repository.getAlbums(term: "").map({ $0.count }).toBlocking().first(), 1)
    }
    
    func testWhenItunesRepositoryReturnsEmpty() throws {
        let repository = MockEmptyItunesRepository()
        XCTAssertTrue(try repository.getAlbums(term: "").map({ $0.isEmpty }).toBlocking().first() == true)
    }
    
    func testWhenItunesRepositoryReturnsError() throws {
        let repository = MockErrorItunesRepository()
        XCTAssertEqual(try repository.getAlbums(term: "").catchAndReturn([]).map({ $0.count }).toBlocking().first(), 0)
    }
}
