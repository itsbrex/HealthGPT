//
// This source file is part of the Stanford HealthGPT project
//
// SPDX-FileCopyrightText: 2023 Stanford University & Project Contributors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import XCTest
import XCTestExtensions


final class HealthGPTViewUITests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments = ["--showOnboarding", "--resetKeychainStorage", "--mockMode"]
        app.deleteAndLaunch(withSpringboardAppName: "HealthGPT")
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testChatView() throws {
        let app = XCUIApplication()
        try app.conductOnboardingIfNeeded()
        
        XCTAssert(app.buttons["Record Message"].waitForExistence(timeout: 2))
        
        try app.textFields["Message Input Textfield"].enter(value: "New Message!")
        
        XCTAssert(app.buttons["Send Message"].waitForExistence(timeout: 2))
        app.buttons["Send Message"].tap()
        
        sleep(3)
        
        XCTAssert(app.staticTexts["Mock Message from SpeziLLM!"].waitForExistence(timeout: 5))
    }
    
    func testSettingsView() throws {
        let app = XCUIApplication()
        try app.conductOnboardingIfNeeded()

        let settingsButton = app.buttons["settingsButton"]
        XCTAssertTrue(settingsButton.waitForExistence(timeout: 5))
        settingsButton.tap()
        
        XCTAssert(app.staticTexts["Settings"].waitForExistence(timeout: 2))
        
        XCTAssertTrue(app.buttons["Open AI API Key"].exists)
        app.buttons["Open AI API Key"].tap()
        app.navigationBars.buttons["Settings"].tap()
        
        XCTAssertTrue(app.buttons["Open AI Model"].exists)
        app.buttons["Open AI Model"].tap()
        
        let picker = app.pickers["modelPicker"]
        let optionToSelect = picker.pickerWheels.element(boundBy: 0)
        optionToSelect.adjust(toPickerWheelValue: "gpt-4o")
        
        app.buttons["Save OpenAI Model"].tap()
        
        XCTAssertTrue(app.staticTexts["Enable Text to Speech"].exists)
        
        XCTAssert(app.buttons["Done"].exists)
        app.buttons["Done"].tap()
        
        settingsButton.tap()
        XCTAssertTrue(app.buttons["Reset Chat"].exists)
        app.buttons["Reset Chat"].tap()
        
        XCTAssert(app.staticTexts["HealthGPT"].waitForExistence(timeout: 2))
    }
    
    func testResetChat() throws {
        let app = XCUIApplication()
        try app.conductOnboardingIfNeeded()
        
        let resetChatButton = app.buttons["resetChatButton"]
        XCTAssertTrue(resetChatButton.waitForExistence(timeout: 5))
        resetChatButton.tap()
    }
}
