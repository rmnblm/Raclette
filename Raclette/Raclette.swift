//
//  Raclette.swift
//  Raclette
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import UIKit

public class Raclette: NSObject {
  public fileprivate(set) var sections = [SectionType]()
  public weak var scrollViewDelegate: UIScrollViewDelegate?
  public var isRowHighlightingEnabled = true
  public var isDynamicRowHeightEnabled = true
  public var isAutomaticRowDeselectionEnabled = true

  private weak var tableView: UITableView?

  public init(tableView: UITableView) {
    self.tableView = tableView
    super.init()
    tableView.delegate = self
    tableView.dataSource = self
  }

  deinit {
    tableView?.delegate = nil
    tableView?.dataSource = nil
    scrollViewDelegate = nil
  }
}

extension Raclette {
  /// Gets the count of all rows in all sections
  public var rowCount: Int {
    get {
      return (sections.map { return $0.rows.count }).reduce(0, +)
    }
  }

  /// Adds a row to the last section.
  @discardableResult public func addRow(_ row: RowType? = nil) -> RowType {
    return lastSection().addRow(row)
  }

  /// Creates and adds a new row to the last section.
  @discardableResult public func createRow<T>(_ closure: ((Row<T>) -> Void)) -> RowType {
    return lastSection().addRow(Row<T>() { closure($0) })
  }

  /// Returns the last section of the table.
  @discardableResult public func lastSection() -> SectionType {
    guard let section = sections.last else {
      return addSection()
    }
    return section
  }

  /// Add a new section to the table. If no section is passed as parameter, a new section will be added to the table and returned.
  @discardableResult public func addSection(_ section: SectionType? = nil) -> SectionType {
    let newSection = section ?? Section()
    sections.append(newSection)
    return newSection
  }

  /// Creates and adds a new section to the table.
  @discardableResult public func createSection(_ closure: ((Section) -> Void)) -> SectionType {
    return addSection(Section() { closure($0) })
  }

  // Removes all sections of the table.
  public func clearSections() {
    sections.removeAll()
  }

  /// Returns a section at the specified index, returns nil if the index is out of bounds.
  public func section(at index: Int) -> SectionType? {
    return sections.indices.contains(index) ? sections[index] : nil
  }
}

extension Raclette: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sectionType = self.section(at: section) else {
      return 0
    }
    return sectionType.rows.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = sections[indexPath.section].rows[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
    if let delegate = row as? RowDelegateType {
      delegate.configure(cell)
    }
    return cell
  }

  public func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let sectionType = self.section(at: section) else {
      return nil
    }
    return sectionType.headerTitle
  }

  public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    guard let sectionType = self.section(at: section) else {
      return nil
    }
    return sectionType.footerTitle
  }
}

extension Raclette: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return calculateHeight(tableView, forRowAt: indexPath)
  }

  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return calculateHeight(tableView, forRowAt: indexPath)
  }

  private func calculateHeight(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> CGFloat {
    let row = sections[indexPath.section].rows[indexPath.row]

    if let staticRowHeight = row.height {
      return staticRowHeight
    }

    if row.dynamicHeight || isDynamicRowHeightEnabled {
      return UITableViewAutomaticDimension
    }

    return tableView.rowHeight
  }

  public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    let row = sections[indexPath.section].rows[indexPath.row]
    guard let cell = tableView.cellForRow(at: indexPath), let delegate = row as? RowDelegateType else {
      return isRowHighlightingEnabled
    }

    return delegate.shouldHighlight(tableView, cell: cell, indexPath: indexPath) ?? isRowHighlightingEnabled
  }

  public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    let row = sections[indexPath.section].rows[indexPath.row]
    guard let cell = tableView.cellForRow(at: indexPath), let delegate = row as? RowDelegateType else {
      return
    }

    delegate.didHighlight(tableView, cell: cell, indexPath: indexPath)
  }

  public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    let row = sections[indexPath.section].rows[indexPath.row]
    guard let cell = tableView.cellForRow(at: indexPath), let delegate = row as? RowDelegateType else {
      return
    }

    delegate.didUnhighlight(tableView, cell: cell, indexPath: indexPath)
  }

  public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    let row = sections[indexPath.section].rows[indexPath.row]
    guard let cell = tableView.cellForRow(at: indexPath), let delegate = row as? RowDelegateType else {
      return indexPath
    }

    return delegate.willSelect(tableView, cell: cell, indexPath: indexPath)
  }

  public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
    let row = sections[indexPath.section].rows[indexPath.row]
    guard let cell = tableView.cellForRow(at: indexPath), let delegate = row as? RowDelegateType else {
      return indexPath
    }

    return delegate.willDeselect(tableView, cell: cell, indexPath: indexPath)
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = sections[indexPath.section].rows[indexPath.row]
    guard let cell = tableView.cellForRow(at: indexPath), let delegate = row as? RowDelegateType else {
      return
    }

    delegate.didSelect(tableView, cell: cell, indexPath: indexPath)

    if isAutomaticRowDeselectionEnabled {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }

  public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let row = sections[indexPath.section].rows[indexPath.row]
    guard let cell = tableView.cellForRow(at: indexPath), let delegate = row as? RowDelegateType else {
      return
    }

    delegate.didDeselect(tableView, cell: cell, indexPath: indexPath)
  }
}

extension Raclette: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollViewDelegate?.scrollViewDidScroll?(scrollView)
  }

  public func scrollViewDidZoom(_ scrollView: UIScrollView) {
    scrollViewDelegate?.scrollViewDidZoom?(scrollView)
  }

  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    scrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
  }

  public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    scrollViewDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
  }

  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    scrollViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
  }

  public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    scrollViewDelegate?.scrollViewWillBeginDecelerating?(scrollView)
  }

  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    scrollViewDelegate?.scrollViewDidEndDecelerating?(scrollView)
  }

  public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    scrollViewDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
  }

  public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return scrollViewDelegate?.viewForZooming?(in: scrollView)
  }

  public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    scrollViewDelegate?.scrollViewWillBeginZooming!(scrollView, with: view)
  }

  public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    scrollViewDelegate?.scrollViewDidEndZooming!(scrollView, with: view, atScale: scale)
  }

  public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
    return scrollViewDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
  }

  public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    scrollViewDelegate?.scrollViewDidScrollToTop?(scrollView)
  }
}

