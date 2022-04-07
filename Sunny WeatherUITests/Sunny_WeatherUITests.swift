//
//  Sunny_WeatherUITests.swift
//  Sunny WeatherUITests
//
//  Created by Emre Dogan on 07/04/2022.
//

import XCTest

class Sunny_WeatherUITests: XCTestCase {
    
    func testShowTextField() {
        
        let app = XCUIApplication()
        app.launch()
        
        let emptyCityTextField = app.staticTexts["City Name"]
        let locationTable = app.tables
        let istanbulText = locationTable/*@START_MENU_TOKEN@*/.staticTexts["Istanbul"]/*[[".cells.staticTexts[\"Istanbul\"]",".staticTexts[\"Istanbul\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let filledTextView = app.staticTexts["Fatih, Istanbul, Tyrkiet"]
        let searchSearchField = app.navigationBars["searchBar"]/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".otherElements[\"searchBar\"].searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        emptyCityTextField.tap()
        searchSearchField.typeText("Istanbul")
        sleep(1)
        XCTAssertTrue(istanbulText.exists)
        istanbulText.tap()
        sleep(1)
        XCTAssertTrue(filledTextView.exists)
        filledTextView.tap()
        sleep(1)
        XCTAssertTrue(searchSearchField.exists)
    }

    
}
