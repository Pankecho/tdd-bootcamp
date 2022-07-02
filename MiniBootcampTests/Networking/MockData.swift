//
//  MockData.swift
//  MiniBootcampTests
//
//  Created by Juan Pablo Martinez Ruiz on 02/07/22.
//

import Foundation

final class MockDataTask: URLSessionDataTask {
    private let closure: () -> ()

    init(closure: @escaping () -> ()) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
