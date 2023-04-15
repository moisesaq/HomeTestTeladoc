//
//  AlbumTests.swift
//  HomeTestTeladocTests
//
//  Created by Moises Apaza on 15/04/2023.
//

import XCTest
@testable import HomeTestTeladoc

final class AlbumTests: XCTestCase {

    func testCorrectAlbum() {
        let album = Album(collectionId: 123, collectionName: "", artistName: "", artworkUrl100: "https://www.apple.com")
        XCTAssertEqual(album.id, String(album.collectionId))
        XCTAssertNotNil(album.getAlbumImage())
    }
    
    func testAlbumWithoutImage() {
        let album = Album(collectionId: 456, collectionName: "", artistName: "", artworkUrl100: "")
        XCTAssertNil(album.getAlbumImage())
    }
}
