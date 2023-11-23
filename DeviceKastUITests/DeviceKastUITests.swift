//
//  DeviceKastUITests.swift
//  DeviceKastUITests
//
//  Created by Burak Ocbe on 18/04/2023.
//

import XCTest

final class DeviceKastUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        
//        let tabBar = app.tabBars["Tab Bar"]
//        let profielButton = tabBar.buttons["Profiel"]
//        let uitloggenButton = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Uitloggen"]/*[[".cells.buttons[\"Uitloggen\"]",".buttons[\"Uitloggen\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        
//        app.buttons["Inloggen met Google"].tap()
//        app.alerts["“DeviceKast” Wants to Use “google.com” to Sign In"].scrollViews.otherElements.buttons["Continue"].tap()
//        app/*@START_MENU_TOKEN@*/.webViews.webViews.webViews.staticTexts["Burak Ocbe"]/*[[".otherElements[\"BrowserView?IsPageLoaded=true&WebViewProcessID=50602\"].webViews.webViews.webViews",".otherElements[\"Inloggen - Google Accounts\"]",".links[\"Burak Ocbe burak.ocbe@icapps.com\"]",".links[\"Burak Ocbe\"].staticTexts[\"Burak Ocbe\"]",".staticTexts[\"Burak Ocbe\"]",".webViews.webViews.webViews"],[[[-1,5,1],[-1,0,1]],[[-1,4],[-1,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,2,3]],[[-1,4],[-1,3]]],[0,0]]@END_MENU_TOKEN@*/.tap()
//        tabBar.buttons["Toestellen"].tap()
//        profielButton.tap()
//        uitloggenButton.tap()
//        
//    }
}
