//
//  SearchTweetModelTests.swift
//  MiniBootcampTests
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import XCTest
@testable import MiniBootcamp

class SearchTweetModelTests: XCTestCase {
    func test_searchTweetModel_correctDecodeResponse() throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "searchTweetsFake", ofType: "json") else { fatalError("Couldn't find searchTweetsFake.json file") }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let sut = try JSONDecoder().decode(SearchTweet.self, from: data)

        XCTAssertTrue(sut.items.count > 0)
        XCTAssertEqual(sut.items.first?.id, "id")
        XCTAssertEqual(sut.items.first?.text, "This is an example")
        XCTAssertEqual(sut.items.first?.favs, 100)
        XCTAssertEqual(sut.items.first?.retweets, 10)
        XCTAssertNotNil(sut.items.first?.user)
    }
}
