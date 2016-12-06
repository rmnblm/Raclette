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
}

extension Row: RowDelegateType {
    func configure(_ cell: UITableViewCell) {
        guard let typedCell = cell as? T else {
            fatalError()
        }
        configuration?(typedCell)
    }
    }
}
