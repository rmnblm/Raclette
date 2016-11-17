//
//  Raclette.swift
//  Raclette
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import UIKit

public class Raclette: NSObject {
    public var scrollViewDelegate: UIScrollViewDelegate?
    public fileprivate(set) var sections = [SectionType]()
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
}

extension Raclette: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
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
        return sections[section].headerTitle
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerTitle
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
        if row.dynamicHeight {
            return UITableViewAutomaticDimension
        }
        return row.height ?? tableView.rowHeight
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
