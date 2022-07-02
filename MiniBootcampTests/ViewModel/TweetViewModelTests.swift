//
//  TweetViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import XCTest
@testable import MiniBootcamp

class TweetViewModelTests: XCTestCase {
    func test_initial_state() throws {
        // Given
        let tweet = try TweetStub().tweetStub()

        // When
        let sut = TweetViewModel(tweet: tweet)

        // Then
        XCTAssertTrue(!sut.content.isEmpty)
        XCTAssertTrue(!sut.userName.isEmpty)
        XCTAssertTrue(!sut.screenName.isEmpty)
    }
}
