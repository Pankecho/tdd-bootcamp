//
//  SearchViewControllerTests.swift
//  MiniBootcampTests
//
//  Created by Juan Pablo Martinez Ruiz on 23/06/22.
//

import XCTest
@testable import MiniBootcamp

class SearchViewControllerTests: XCTestCase {
    var sut: SearchViewController!
    var vm: SearchViewModel!
    var api: SearchTweetAPI!
    var fakeSession: FakeSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeSession = FakeSession()
        api = SearchTweetAPI(session: fakeSession)
        vm = SearchViewModel(provider: api)
        sut = SearchViewController(viewModel: vm)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        fakeSession = nil
        api = nil
        vm = nil
        sut = nil
        try super.tearDownWithError()
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

    func testViewController_whenSearch_viewModel_state() {
        // When
        sut.viewModel.search(with: "Test")

        // Then
        XCTAssertEqual(sut.viewModel.state.value, .loading)
    }

    func testViewController_whenSearch_ReloadsTableView() throws {
        // Given
        fakeSession.data = try SearchTweetStub().searchData()
        let expectation = expectation(description: "search tweets")
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)

        // When
        sut.viewModel.search(with: "test")

        // Then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue((sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0))! == 0)
        } else {
            XCTFail("tableView was not reloaded")
        }
    }

    func test_searchBar_navigationItem() {
        let searchBar = sut.navigationItem.titleView as? UISearchBar
        XCTAssertNotNil(searchBar)
        XCTAssertEqual(searchBar?.placeholder, "Search tweets")
        XCTAssertNotNil(searchBar?.delegate)
    }

    func test_searchBar_delegate() throws {
        fakeSession.data = try SearchTweetStub().searchData()
        let expectation = expectation(description: "search tweets")
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        let searchBar = sut.navigationItem.titleView as? UISearchBar
        searchBar?.text = "Test"

        searchBar?.delegate?.searchBarCancelButtonClicked?(searchBar!)

        // Then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue((sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0))! == 0)
        } else {
            XCTFail("tableView was not reloaded")
        }
    }
}
