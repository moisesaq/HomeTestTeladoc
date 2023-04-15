//
//  AlbumsViewModelTests.swift
//  HomeTestTeladocTests
//
//  Created by Moises Apaza on 15/04/2023.
//

import XCTest
import Combine
@testable import HomeTestTeladoc

final class AlbumsViewModelTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Waiting for view model to load albums")
    var cancellables: [AnyCancellable] = []
    
    func testWhenViewModelLoadsOneAlbum() {
        let viewModel = AlbumsViewModel(itunesRepository: MockItunesRepository())
        
        viewModel.$albums.dropFirst().sink { value in
            XCTAssertEqual(value.count, 1)
            self.expectation.fulfill()
        }.store(in: &cancellables)
        viewModel.loadAlbumsOfTheBeatles()
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenViewModelLoadsEmptyAlbums() {
        let viewModel = AlbumsViewModel(itunesRepository: MockEmptyItunesRepository())
        
        viewModel.$albums.dropFirst().sink { value in
            XCTAssertTrue(value.isEmpty)
            self.expectation.fulfill()
        }.store(in: &cancellables)
        viewModel.loadAlbumsOfTheBeatles()
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenViewModelThrowsError() {
        let viewModel = AlbumsViewModel(itunesRepository: MockErrorItunesRepository())
        let expectation = XCTestExpectation(description: "Waiting for the view model to throw error")
        viewModel.$hasError.dropFirst().sink { value in
            XCTAssertTrue(value)
            expectation.fulfill()
        }.store(in: &cancellables)
        viewModel.loadAlbumsOfTheBeatles()
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenViewModelShowsLoading() {
        let viewModel = AlbumsViewModel(itunesRepository: MockItunesRepository())
        let showExpectation = XCTestExpectation(description: "Waiting for the view model to show loading")
        let hideExpectation = XCTestExpectation(description: "Waiting for the view model to hide loading")
        
        viewModel.$loading.dropFirst().sink { value in
            value ? showExpectation.fulfill() : hideExpectation.fulfill()
        }.store(in: &cancellables)
        viewModel.loadAlbumsOfTheBeatles()
        wait(for: [showExpectation], timeout: 1)
        XCTAssertTrue(viewModel.loading)
        wait(for: [hideExpectation], timeout: 1)
        XCTAssertFalse(viewModel.loading)
    }
}
