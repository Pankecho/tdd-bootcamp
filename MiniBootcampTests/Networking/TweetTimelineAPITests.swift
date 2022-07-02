//
//  TweetTimelineAPITests.swift
//  MiniBootcampTests
//
//  Created by Abner Castro on 21/06/22.
//

import XCTest
@testable import MiniBootcamp

class TweetTimelineAPITests: XCTestCase {
    
    var sut: TweetTimelineAPI!
    private var session: FakeSession!
    
    override func setUp() {
        super.setUp()
        session = FakeSession()
        sut = TweetTimelineAPI(session: session)
    }
    
    func testNetworkResponse() {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var response = false
        
        // when
        sut.load(.timeline) { result in
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
        sut.load(.timeline) { result in
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
        sut.load(.timeline) { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 3.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .noData)
    }
    
    func testResponseWithParsingError() throws {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var expectedError: TweetAPIError?
        session.data = Data()
        
        
        // when
        sut.load(.timeline) { result in
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
        var timeline = [Tweet]()
        session.data = try TweetStub().tweetsData(number: 3)

        // when
        sut.load(.timeline) { result in
            switch result {
            case .success(let tweets):
                timeline = tweets
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(timeline.count, 3)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        session = nil
    }

}
