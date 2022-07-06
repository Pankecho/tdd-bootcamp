//
//  SearchTweetViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import XCTest
@testable import MiniBootcamp

class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    var api: SearchTweetAPI!
    var fakeSession: FakeSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeSession = FakeSession()
        api = SearchTweetAPI(session: fakeSession)
        sut = SearchViewModel(provider: api)
    }

    override func tearDownWithError() throws {
        fakeSession = nil
        api = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_searchTweets_loading_state() {
        // When
        sut.search(with: "test")

        // Then
        XCTAssertEqual(sut.state.value, .loading)
    }

    func test_searchTweets_success_loading_state() throws {
        // Given
        fakeSession.data = try SearchTweetStub().searchData()
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet search")
        sut.state.bind { state in
            switch state {
            case .success:
                changeState = true
                expectation.fulfill()
            default:
                break
            }
        }

        // When
        sut.search(with: "test")

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }

    func test_searchTweets_failure_loading_state() throws {
        // Given
        fakeSession.data = try SearchTweetStub().errorSearchData()
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet search")
        sut.state.bind { state in
            switch state {
            case .failure:
                changeState = true
                expectation.fulfill()
            default:
                break
            }
        }

        // When
        sut.search(with: "test")

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }

    func test_searchTweets_success_data() throws {
        // Given
        fakeSession.data = try SearchTweetStub().searchData()
        let expectation = expectation(description: "Fetched tweet search")
        sut.state.bind { state in
            switch state {
            case .success:
                expectation.fulfill()
            default:
                break
            }
        }

        // When
        sut.search(with: "test")

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(sut.tweetsCount > 0)
    }

    func test_getItem() throws {
        // Given
        fakeSession.data = try SearchTweetStub().searchData()
        let expectation = expectation(description: "Fetched tweet search")
        sut.state.bind { state in
            switch state {
            case .success:
                expectation.fulfill()
            default:
                break
            }
        }

        // When
        sut.search(with: "test")
        wait(for: [expectation], timeout: 5.0)
        let item = sut.getItem(at: 0)

        // Then
        XCTAssertEqual(item.content, "This is an example")
        XCTAssertEqual(item.screenName, "@wizeboot")
        XCTAssertEqual(item.userName, "Wizeboot")
    }
}
