//
//  SearchViewModel.swift
//  MiniBootcamp
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import Foundation

final class SearchViewModel {
    let provider: SearchTweetAPI
    var state: Observer<ViewModelState> = Observer<ViewModelState>()
    var item: SearchTweet = SearchTweet(items: [])

    var tweetsCount: Int {
        return item.items.count
    }

    init(provider: SearchTweetAPI) {
        self.provider = provider
    }

    func search(with value: String) {
        state.value = .loading
        provider.load(.search(value)) { result in
            switch result {
            case .success(let search):
                self.item = search
                self.state.value = .success
            case .failure(_):
                self.state.value = .failure
            }
        }
    }

    func getItem(at index: Int) -> TweetViewModel {
        return .init(tweet: item.items[index])
    }
}
