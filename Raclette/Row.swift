//
//  Row.swift
//  Raclette
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import UIKit

public class Row<T: UITableViewCell>: RowType {
    public typealias Configuration = (T) -> Void
    public typealias TableInformation = (tableView: UITableView, indexPath: IndexPath)

    public init() { }

    public init(closure: ((Row<T>) -> Void)) {
        closure(self)
    }

    public var height: CGFloat?
    public var dynamicHeight: Bool = true

    private var _reuseIdentifier: String?
    public var reuseIdentifier: String {
        get {
            guard let identifier = _reuseIdentifier else {
                return String(describing: T.self)
            }
            return identifier
        }
        set {
            _reuseIdentifier = newValue
        }
    }

    public var configuration: Configuration?
    public var shouldHighlight: ((T, TableInformation) -> Bool)?
    public var didHighlight: ((T, TableInformation) -> Void)?
    public var didUnhighlight: ((T, TableInformation) -> Void)?
    public var willSelect: ((T, TableInformation) -> IndexPath?)?
    public var willDeselect: ((T, TableInformation) -> IndexPath?)?
    public var didSelect: ((T, TableInformation) -> Void)?
    public var didDeselect: ((T, TableInformation) -> Void)?
}

extension Row: RowDelegateType {
    func configure(_ cell: UITableViewCell) {
        guard let typedCell = cell as? T else {
            fatalError()
        }
        configuration?(typedCell)
    }

    func shouldHighlight(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) -> Bool? {
        guard let typedCell = cell as? T else {
            return nil
        }
        return shouldHighlight?(typedCell, (tableView, indexPath)) ?? nil
    }

    func didHighlight(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        guard let typedCell = cell as? T else {
            return
        }
        didHighlight?(typedCell, (tableView, indexPath))
    }

    func didUnhighlight(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        guard let typedCell = cell as? T else {
            return
        }
        didUnhighlight?(typedCell, (tableView, indexPath))
    }

    func willSelect(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) -> IndexPath? {
        guard let typedCell = cell as? T else {
            return indexPath
        }
        return willSelect?(typedCell, (tableView, indexPath)) ?? indexPath
    }

    func willDeselect(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) -> IndexPath? {
        guard let typedCell = cell as? T else {
            return indexPath
        }
        return willDeselect?(typedCell, (tableView, indexPath)) ?? indexPath
    }

    func didSelect(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        guard let typedCell = cell as? T else {
            return
        }
        didSelect?(typedCell, (tableView, indexPath))
    }

    func didDeselect(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        guard let typedCell = cell as? T else {
            return
        }
        didDeselect?(typedCell, (tableView, indexPath))
    }
}
