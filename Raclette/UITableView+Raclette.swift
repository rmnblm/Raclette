//
//  UITableView+Raclette.swift
//  Raclette
//
//  Created by Roman Blum on 16.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import UIKit

private let instanceKey = "RacletteInstance"

public extension UITableView {
    private var raclette: Raclette {
        get {
            guard let racletteInstance = layer.value(forKey: instanceKey) as? Raclette else {
                let raclette = Raclette()
                delegate = raclette
                dataSource = raclette
                register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
                layer.setValue(raclette, forKey: instanceKey)
                return raclette
            }
            return racletteInstance
        }
    }

    /// Gets or sets the delegate to redirect all calls to `UIScrollViewDelegate`.
    public var scrollViewDelegate: UIScrollViewDelegate? {
        get {
            return raclette.scrollViewDelegate
        }
        set {
            raclette.scrollViewDelegate = newValue
        }
    }

    // Gets or sets a boolean value if dynamic height of rows is globally enabled or not
    public var isDynamicRowHeightEnabled: Bool {
        get {
            return raclette.isDynamicRowHeightEnabled
        }
        set {
            raclette.isDynamicRowHeightEnabled = newValue
        }
    }
    
    /// Adds a row to the last section.
    @discardableResult public func addRow(_ row: RowType? = nil) -> RowType {
        return raclette.addRow(row)
    }

    /// Creates and adds a new row to the last section.
    @discardableResult public func createRow<T>(_ closure: ((Row<T>) -> Void)) -> RowType {
        return raclette.createRow(closure)
    }

    /// Returns the last section of the table.
    @discardableResult public func lastSection() -> SectionType {
        return raclette.lastSection()
    }

    /// Add a new section to the table. If no section is passed as parameter, a new section will be added to the table and returned.
    @discardableResult public func addSection(_ section: SectionType? = nil) -> SectionType {
        return raclette.addSection(section)
    }

    /// Creates and adds a new section to the table.
    @discardableResult public func createSection(_ closure: ((Section) -> Void)) -> SectionType {
        return raclette.createSection(closure)
    }

    // Removes all sections of the table.
    public func clearSections() {
        raclette.clearSections()
    }
}
