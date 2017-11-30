//
//  MenuAppUITests.swift
//  MenuAppUITests
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import XCTest

class MenuAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        XCUIApplication().launch()
    }
    
    func testExample() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let hamburgersStaticText = collectionViewsQuery.staticTexts["Hamburgers"]
        hamburgersStaticText.tap()
        collectionViewsQuery.staticTexts["Dave's Single®"].tap()
        app.buttons["Allergens"].tap()
        app.staticTexts["Wheat, soy, milk, and egg"].tap()
        app.buttons["Nutrition"].tap()
        app.staticTexts["570 Calories, 10 g Fat, 1 g Fiber, 4 g Protein"].tap()
        app.buttons["Ingredients"].tap()
        app.staticTexts["Beef, bun, ketchup, mustard, pickles"].tap()
        app.navigationBars["Your Fresh Menu"].buttons["Back"].tap()
        app.navigationBars["Hamburgers"].buttons["Back"].tap()
    }
    
}
