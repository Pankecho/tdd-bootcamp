//
//  FeedViewModel.swift
//  MiniBootcamp
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import Foundation

enum ViewModelState {
    case loading
    case success
    case failure
}

final class FeedViewModel {
    let provider: TweetTimelineAPI
    var state: Observer<ViewModelState> = Observer<ViewModelState>()
    var tweets: [Tweet] = [Tweet]()

    init(provider: TweetTimelineAPI) {
        self.provider = provider
    }

    func getTweets() {
        state.value = .loading
        provider.load(.timeline) { [unowned self] result in
            switch result {
            case .success(let tweets):
                self.tweets = tweets
                self.state.value = .success
            case .failure(_):
                self.state.value = .failure
            }
        }
    }
}
