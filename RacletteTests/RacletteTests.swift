//
//  RacletteTests.swift
//  RacletteTests
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import XCTest

class RacletteTests: XCTestCase {

  func testThat_whenRacletteIsInitialized_itHasZeroSections() {
    let raclette = Raclette()

    XCTAssertEqual(raclette.sections.count, 0)
  }

  func testThat_whenAddingASingleSection_itHasOneSection() {
    let raclette = Raclette()
    raclette.addSection()

    XCTAssertEqual(raclette.sections.count, 1)
  }

  func testThat_whenAddingMultipleSections_itHasMultipleSections() {
    let times = 10
    let raclette = Raclette()

    (1...times).forEach { number in
      raclette.addSection()
    }

    XCTAssertEqual(raclette.sections.count, 10)
  }

  func testThat_whenAddingARowWithoutASection_itAutomaticallyCreatesASection() {
    let raclette = Raclette()
    raclette.addRow()

    XCTAssertEqual(raclette.sections.count, 1)

    let section = raclette.lastSection()
    XCTAssertEqual(section.rows.count, 1)
  }

  func testThat_whenAddingMultipleSectionsAndRows_itHasACorrectRowCount() {
    let times = 10
    let raclette = Raclette()

    (1...times).forEach { number in
      raclette.addSection()
      (1...times).forEach { number in
        raclette.addRow()
      }
    }

    XCTAssertEqual(raclette.sections.count, 10)
    XCTAssertEqual(raclette.rowCount, times * times)
  }

  func testThat_whenClearingAllSections_itHasZeroSectionsAndRows() {
    let raclette = Raclette()
    raclette.addRow()

    XCTAssertEqual(raclette.sections.count, 1)
    XCTAssertEqual(raclette.rowCount, 1)

    raclette.clearSections()

    XCTAssertEqual(raclette.sections.count, 0)
    XCTAssertEqual(raclette.rowCount, 0)
  }

  func testThat_whenAccessingASectionByInvalidIndex_itReturnsNil() {
    let raclette = Raclette()

    XCTAssertEqual(raclette.sections.count, 0)
    XCTAssertNil(raclette.section(at: 1))
  }

  func testThat_whenAccessingASectionByValidIndex_itReturnsNil() {
    let raclette = Raclette()
    raclette.addSection()

    XCTAssertEqual(raclette.sections.count, 1)
    XCTAssertNotNil(raclette.section(at: 0))
  }
}

