//
//  TweetCellTests.swift
//  MiniBootcampTests
//
//  Created by Abner Castro on 14/06/22.
//

import XCTest
@testable import MiniBootcamp

class TweetCellTests: XCTestCase {
    private var sut: TweetCell!
    
    override func setUp() {
        super.setUp()
        sut = TweetCell()
    }
    
    func testCellIsNotNil() {
        // Given
        // system under test
        let sut = TweetCell()
        
        // When
        
        // Then
        XCTAssertNotNil(sut)
    }
    
    func testBackgroundIsSystem() {
        let systemBackground = UIColor.systemBackground
        XCTAssertEqual(sut.backgroundColor, systemBackground)
    }

    func testSelectionStyle() {
        XCTAssertEqual(sut.selectionStyle, .none)
    }
    
    func testuserImageView_initialConfiguration() {
        let defaultThumb = UIImage(.gato)
        XCTAssertEqual(sut.userImageView.layer.cornerRadius, 25)
        XCTAssertTrue(sut.userImageView.clipsToBounds)
        XCTAssertEqual(sut.userImageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.userImageView.image, defaultThumb)
    }
    
    func testNameLabel_initialConfiguration() {
        // Given
        let font = UIFont.bold(withSize: .name)
        let textColor = UIColor.label
        
        //Then
        XCTAssertEqual(sut.nameLabel.font, font)
        XCTAssertEqual(sut.nameLabel.numberOfLines, 1)
        XCTAssertTrue(sut.nameLabel.adjustsFontSizeToFitWidth)
        XCTAssertEqual(sut.nameLabel.textColor, textColor)
    }
    
    func testusernameLabel_initialConfiguration() {
        // Given
        let font = UIFont.bold(withSize: .username)
        let textColor = UIColor.systemGray
        
        //Then
        XCTAssertEqual(sut.usernameLabel.font, font)
        XCTAssertEqual(sut.usernameLabel.numberOfLines, 1)
        XCTAssertEqual(sut.usernameLabel.textColor, textColor)
    }
    
    func testContentLabel_initialConfiguration() {
        // Given
        let font = UIFont.normal(withSize: .content)
        let textColor = UIColor.label
        
        //Then
        XCTAssertEqual(sut.contentLabel.font, font)
        XCTAssertEqual(sut.contentLabel.numberOfLines, 0)
        XCTAssertEqual(sut.contentLabel.textColor, textColor)
    }
    
    func testAllSubviewsAreAddedAsSubviews() {
        XCTAssertEqual(sut.subviews.count, 5)
    }

    func testCommentButton_initialConfiguration() {
        // Given
        let thumb = UIImage(.comment)
        let tintColor = UIColor.redMain

        // When

        // Then
        XCTAssertNotNil(sut.commentButton)
        XCTAssertEqual(sut.commentButton.image(for: .normal), thumb)
        XCTAssertTrue(sut.commentButton.clipsToBounds)
        XCTAssertEqual(sut.commentButton.tintColor, tintColor)
    }

    func testRetweetButton_initialConfiguration() {
        // Given
        let thumb = UIImage(.ret)
        let tintColor = UIColor.redMain

        // When

        // Then
        XCTAssertNotNil(sut.retweetButton)
        XCTAssertEqual(sut.retweetButton.image(for: .normal), thumb)
        XCTAssertTrue(sut.retweetButton.clipsToBounds)
        XCTAssertEqual(sut.retweetButton.tintColor, tintColor)
    }

    func testFavButton_initialConfiguration() {
        // Given
        let thumb = UIImage(.fav)
        let tintColor = UIColor.redMain

        // When

        // Then
        XCTAssertNotNil(sut.favButton)
        XCTAssertEqual(sut.favButton.image(for: .normal), thumb)
        XCTAssertTrue(sut.favButton.clipsToBounds)
        XCTAssertEqual(sut.favButton.tintColor, tintColor)
    }

    func testShareButton_initialConfiguration() {
        // Given
        let thumb = UIImage(.share)
        let tintColor = UIColor.redMain

        // When

        // Then
        XCTAssertNotNil(sut.shareButton)
        XCTAssertEqual(sut.shareButton.image(for: .normal), thumb)
        XCTAssertTrue(sut.shareButton.clipsToBounds)
        XCTAssertEqual(sut.shareButton.tintColor, tintColor)
    }

    func testButtonStackView() {
        // Given

        // When

        // Then
        XCTAssertNotNil(sut.buttonStackView)
        XCTAssertEqual(sut.buttonStackView.axis, .horizontal)
        XCTAssertEqual(sut.buttonStackView.distribution, .equalSpacing)
        XCTAssertEqual(sut.buttonStackView.alignment, .center)
        XCTAssertEqual(sut.buttonStackView.arrangedSubviews.count, 4)
    }

    func testConfigureCell() {
        // Given
        let nameText = "WizeBot"
        let userName = "Wizebot"
        let text = "This is a text test"

        // When
        sut.configure(name: nameText, username: userName, text: text)

        // Then
        XCTAssertEqual(sut.nameLabel.text, nameText)
        XCTAssertEqual(sut.usernameLabel.text, "@\(userName)")
        XCTAssertEqual(sut.contentLabel.text, text)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
