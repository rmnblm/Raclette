//
//  UITableViewExtensionTests.swift
//  Raclette
//
//  Created by Roman Blum on 28.02.17.
//  Copyright © 2017 RMNBLM. All rights reserved.
//

import XCTest
import UIKit

class UITableViewExtensionTests: XCTestCase {

    func testThat_whenRegisteringACell_itCanBeDequeued() {
        let tableView = UITableView()

        XCTAssertNil(tableView.dequeueReusableCell(TestCell.self))

        tableView.register(TestCell.self)

        XCTAssertNotNil(tableView.dequeueReusableCell(TestCell.self))
    }
}
