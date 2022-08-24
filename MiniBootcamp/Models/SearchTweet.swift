//
//  SearchTweet.swift
//  MiniBootcamp
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import Foundation

struct SearchTweet: Codable {
    let items: [Tweet]
}

extension SearchTweet {
    private enum CodingKeys: String, CodingKey {
        case items = "statuses"
    }
}
