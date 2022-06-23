//
//  TweetModelTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 12/04/22.
//

import XCTest
@testable import MiniBootcamp

class TweetModelTests: XCTestCase {
    func test_tweetModel_correctDecodeResponse() throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweetFake", ofType: "json") else { fatalError("Couldn't find tweetFake.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        print(try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed))
        let sut = try JSONDecoder().decode([Tweet].self, from: data)

        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(sut.first?.id, "id")
        XCTAssertEqual(sut.first?.text, "This is an example")
        XCTAssertEqual(sut.first?.favs, 100)
        XCTAssertEqual(sut.first?.retweets, 10)
        XCTAssertNotNil(sut.first?.user)
    }
    
}
