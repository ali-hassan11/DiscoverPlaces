//
//  DiscoverPlacesTests.swift
//  DiscoverPlacesTests
//
//  Created by user on 26/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

import XCTest
@testable import DiscoverPlaces

class StarsViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatStarsStackViewHasCorrectNumberOfSubViews() {
        let starsView1 = StarsView(width: 100)
        starsView1.populate(with: 0)
        
        let starsView2 = StarsView(width: 100)
        starsView2.populate(with: 0.4)
        
        let starsView3 = StarsView(width: 100)
        starsView3.populate(with: 0.9)

        let starsView4 = StarsView(width: 100)
        starsView4.populate(with: 1)
        
        let starsView5 = StarsView(width: 100)
        starsView5.populate(with: 1.7)
        
        let starsView6 = StarsView(width: 100)
        starsView6.populate(with: 2.2)
        
        let starsView7 = StarsView(width: 100)
        starsView7.populate(with: 3.5)
        
        let starsView8 = StarsView(width: 100)
        starsView8.populate(with: 4.7)
        
        let starsView9 = StarsView(width: 100)
        starsView9.populate(with: 4.8)
        
        let starsView10 = StarsView(width: 100)
        starsView10.populate(with: 5)
        
        XCTAssertTrue(starsView1.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView2.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView3.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView4.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView5.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView6.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView7.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView8.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView9.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        XCTAssertTrue(starsView10.starStackView.arrangedSubviews.count == 5, "Incorrect number of views in stars stackView, total should be 5")
        
    }
    

}
