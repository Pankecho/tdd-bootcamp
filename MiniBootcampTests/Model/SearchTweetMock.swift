//
//  SearchTweetMock.swift
//  MiniBootcampTests
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import Foundation
@testable import MiniBootcamp

class SearchTweetStub {
    func searchStub() throws -> SearchTweet {
        guard let path = Bundle(for: type(of: self)).path(forResource: "searchTweetsFake", ofType: "json") else { fatalError("Couldn't find searchTweetsFake.json file") }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(SearchTweet.self, from: data)
    }

    func searchData() throws -> Data {
        let search = try searchStub()
        return try JSONEncoder().encode(search)
    }

    func errorSearchData() throws -> Data {
        guard let path = Bundle(for: type(of: self)).path(forResource: "searchErrorFake", ofType: "json") else { fatalError("Couldn't find searchErrorFake.json file") }

        return try Data(contentsOf: URL(fileURLWithPath: path))
    }
}
