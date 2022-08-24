//
//  FeedViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import XCTest
@testable import MiniBootcamp

class FeedViewModelTests: XCTestCase {
    var sut: FeedViewModel!
    var api: TweetTimelineAPI!
    var fakeSession: FakeSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeSession = FakeSession()
        api = TweetTimelineAPI(session: fakeSession)
        sut = FeedViewModel(provider: api)
    }

    override func tearDownWithError() throws {
        fakeSession = nil
        api = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_getTweets_loading_state() {
      // When
      sut.getTweets()
        
      // Then
      XCTAssertEqual(sut.state.value, .loading)
    }

    func test_getTweets_success_loading_state() throws {
        // Given
        fakeSession.data = try TweetStub().tweetsData(number: 3)
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet timeline")
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
        sut.getTweets()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }

    func test_getTweets_failure_loading_state() throws {
        // Given
        fakeSession.data = try TweetStub().tweetData()
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet timeline")
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
        sut.getTweets()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }

    func test_getTweets_success_data() throws {
        // Given
        fakeSession.data = try TweetStub().tweetsData(number: 3)
        let expectation = expectation(description: "Fetched tweet timeline")
        sut.state.bind { state in
          switch state {
          case .success:
            expectation.fulfill()
          default:
            break
          }
        }

        // When
        sut.getTweets()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(sut.tweetsCount > 0)
    }
}
