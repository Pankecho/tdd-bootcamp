//
//  SearchTweetAPITests.swift
//  MiniBootcampTests
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import XCTest
@testable import MiniBootcamp

class SearchTweetAPITests: XCTestCase {
    var sut: SearchTweetAPI!
    private var session: FakeSession!

    override func setUp() {
        super.setUp()
        session = FakeSession()
        sut = SearchTweetAPI(session: session)
    }

    func testNetworkResponse() {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var response = false

        // when
        sut.load(.search("Hola")) { result in
            response = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(response)
    }

    func testResponseWithError() {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var expectedError: TweetAPIError?
        session.error = TweetAPIError.response

        // when
        sut.load(.search("Hola")) { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }

        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(expectedError)
    }

    func testResponseWithNoData() throws {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var expectedError: TweetAPIError?

        // when
        sut.load(.search("Hola")) { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }

        // then
        wait(for: [expectation], timeout: 5.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .noData)
    }

    func testResponseWithParsingError() throws {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var expectedError: TweetAPIError?
        session.data = Data()

        // when
        sut.load(.search("Hola")) { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }

        // then
        wait(for: [expectation], timeout: 5.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .parsingData)
    }


    func testResponseWithParsing() throws {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var data: SearchTweet = SearchTweet(items: [])
        session.data = try SearchTweetStub().searchData()

        // when
        sut.load(.timeline) { result in
            switch result {
            case .success(let search):
                data = search
                expectation.fulfill()
            default:
                break
            }
        }

        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(data.items.count, 1)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        session = nil
    }

}
