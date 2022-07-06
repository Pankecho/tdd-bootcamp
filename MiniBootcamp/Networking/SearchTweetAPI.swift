//
//  SearchTweetAPI.swift
//  MiniBootcamp
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import Foundation

struct SearchTweetAPI {
    let session: URLSession
    func load(_ endpoint: Endpoint, completion: @escaping (Result<SearchTweet, Error>) -> ()) {
        let request = endpoint.request
        session.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(TweetAPIError.noData))
                return
            }

            do {
                let search = try JSONDecoder().decode(SearchTweet.self, from: data)
                completion(.success(search))
            } catch {
                completion(.failure(TweetAPIError.parsingData))
            }

        }.resume()
    }

}
