//
//  Section.swift
//  Raclette
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import UIKit

public class Section: SectionType {
    public fileprivate(set) var rows = [RowType]()
    public var headerTitle: String?
    public var footerTitle: String?

    public init() { }

    public init(closure: ((Section) -> Void)) {
        closure(self)
    }
}

extension Section {
    /// Add a new row. If no row is passed as parameter, a new row will be added and returned.
    @discardableResult public func addRow(_ row: RowType? = nil) -> RowType {
        let newRow = row ?? Row<UITableViewCell>()
        rows.append(newRow)
        return newRow
    }
}
