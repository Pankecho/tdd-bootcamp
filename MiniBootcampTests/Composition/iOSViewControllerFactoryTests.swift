//
//  iOSViewControllerFactoryTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class iOSViewControllerFactoryTests: XCTestCase {
    func test_feedViewController_isFeedViewControllerType() {
        let sut = iOSViewControllerFactory()
        let feedVC = sut.feedViewController() as? FeedViewController
        XCTAssertNotNil(feedVC)
    }

    func test_searchViewController_isFeedViewControllerType() {
        let sut = iOSViewControllerFactory()
        let searchVC = sut.searchViewController() as? SearchViewController
        XCTAssertNotNil(searchVC)
    }
}
