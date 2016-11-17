//
//  RowTests.swift
//  Raclette
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import XCTest
@testable import Raclette

class RowTests: XCTestCase {
    func testThat_whenCellIsConfigured_itUsesTheConfigurationClosure() {
        var configured = false
        let row = Row()
        row.configuration = { cell in
            configured = true
        }

        XCTAssertFalse(configured)

        row.configure(UITableViewCell())
        XCTAssertTrue(configured)
    }

    func thestThat_whenSettingTheReuseIdentifier_itIsTheSameAfterConfiguration() {
        let staticIdentifier = "MyCell"
        let row = Row()
        row.reuseIdentifier = staticIdentifier

        XCTAssertEqual(staticIdentifier, row.reuseIdentifier)

        row.configure(UITableViewCell())
        XCTAssertEqual(staticIdentifier, row.reuseIdentifier)
    }

    func thestThat_whenSettingTheReuseIdentifier_itIsTheSameAfterConfigurationOfACustomCell() {
        let staticIdentifier = "MyCell"
        let row = Row()
        row.reuseIdentifier = staticIdentifier

        XCTAssertEqual(staticIdentifier, row.reuseIdentifier)

        row.configure(CustomCell())
        XCTAssertEqual(staticIdentifier, row.reuseIdentifier)
    }

    func thestThat_whenNotSettingTheReuseIdentifier_itIsTypeNameOfTheConfiguredCell() {
        let expectedIdentifier = "CustomCell"
        let row = Row<CustomCell>()
        row.configuration = { cell in }

        XCTAssertEqual(expectedIdentifier, row.reuseIdentifier)

        row.configure(CustomCell())
        XCTAssertEqual(expectedIdentifier, row.reuseIdentifier)
    }

    class CustomCell: UITableViewCell { }
}
