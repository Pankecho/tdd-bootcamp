//
//  TweetViewModel.swift
//  MiniBootcamp
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import Foundation

struct TweetViewModel {
    private let tweet: Tweet

    var content: String { tweet.text }

    var userName: String { tweet.user.name }

    var screenName: String { tweet.user.nickname }

    init(tweet: Tweet) {
        self.tweet = tweet
    }
}
