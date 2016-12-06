//
//  SectionTests.swift
//  Raclette
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import XCTest

class SectionTests: XCTestCase {
    func testThat_whenASectionIsInitialized_itHasZeroRows() {
        let section = Section()

        XCTAssertEqual(section.rows.count, 0)
    }

    func testThat_whenAddingARow_itHasOneRow() {
        let section = Section()
        section.addRow()

        XCTAssertEqual(section.rows.count, 1)
    }

    func testThat_whenAddingAPreconfiguredRow_itHasOneRow() {
        let section = Section()
        let row = Row()
        section.addRow(row)

        XCTAssertEqual(section.rows.count, 1)
    }

    func testThat_whenCreatingARow_itHasOneRow() {
        let section = Section()
        section.createRow { row in
        }

        XCTAssertEqual(section.rows.count, 1)
    }

    func testThat_whenAddingMultipleRows_itHasMultipleRows() {
        let times =  10
        let section = Section()
        (1...times).forEach { number in
            section.addRow()
        }

        XCTAssertEqual(section.rows.count, times)
    }

    func testThat_whenAddingMultiplePreconfiguredRows_itHasMultipleRows() {
        let times =  10
        let section = Section()
        (1...times).forEach { number in
            let row = Row()
            section.addRow(row)
        }

        XCTAssertEqual(section.rows.count, times)
    }

    func testThat_whenCreatingMultipleRows_itHasMultipleRows() {
        let times =  10
        let section = Section()
        (1...times).forEach { number in
            section.createRow { row in

            }
        }

        XCTAssertEqual(section.rows.count, times)
    }

    func testThat_whenClearingAllRows_itHasZeroRows() {
        let section = Section()
        section.addRow()

        XCTAssertEqual(section.rows.count, 1)

        section.clearRows()
        XCTAssertEqual(section.rows.count, 0)
    }
}
