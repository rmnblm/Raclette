//
//  Section.swift
//  Raclette
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

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
    let newRow = row ?? Row()
    rows.append(newRow)
    return newRow
  }

  /// Creates a new row.
  @discardableResult public func createRow<T>(_ closure: ((Row<T>) -> Void)) -> RowType {
    return addRow(Row<T>() { closure($0) })
  }

  /// Removes all rows of the section.
  public func clearRows() {
    rows.removeAll()
  }
}

