//
//  FeedViewControllerTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class FeedViewControllerTests: XCTestCase {
    var sut: FeedViewController!
    var vm: FeedViewModel!
    var api: TweetTimelineAPI!
    var fakeSession: FakeSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeSession = FakeSession()
        api = TweetTimelineAPI(session: fakeSession)
        vm = FeedViewModel(provider: api)
        sut = FeedViewController(viewModel: vm)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        fakeSession = nil
        api = nil
        vm = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_vc_title() {
        XCTAssertNotNil(sut.navigationItem)
        XCTAssertEqual(sut.navigationItem.title, "Tweets")
    }

    func test_topRight_searchButton() {
        XCTAssertNotNil(sut.navigationItem)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.tintColor, .black)
    }

    func test_vc_backgroundIsSystemBackground() {
        XCTAssertNotNil(sut.view?.backgroundColor)
        XCTAssertEqual(sut.view?.backgroundColor, .systemBackground)
    }
    
    func testTableView_initialConfiguration() {
        XCTAssertFalse(sut.tableView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testViewControllerHasTableViewAsSubview() {
        XCTAssertEqual(sut.view.subviews.count, 1)
    }

    func testTableViewNumberOfRowsIsOne() {
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
    }

    func testTableViewCell_cellIsTweetCell() {
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TweetCell

        XCTAssertNotNil(cell)
    }

    func testViewController_didLoad_viewModel_state() {
        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(sut.viewModel.state.value, .loading)
    }

    func testViewController_WhenDidLoad_ReloadsTableView() throws {
        // Given
        fakeSession.data = try TweetStub().tweetsData(number: 3)
        let expectation = expectation(description: "load tweets")
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)

        // When
        sut.viewDidLoad()

        // Then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue((sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0))! > 0)
        } else {
            XCTFail("tableView was not reloaded")
        }
    }

    func testViewController_delegate() {
        let delegate = FeedDelegateMock()
        sut.delegate = delegate

        sut.goToSearch()

        XCTAssertNotNil(sut.delegate)
        XCTAssertEqual(delegate.counter, 1)
    }
}

class FeedDelegateMock: FeedViewControllerDelegate {
    var counter: Int = 0

    func goToSearch() {
        counter += 1
    }
}
