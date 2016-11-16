//
//  RowType.swift
//  Raclette
//
//  Created by Roman Blum on 16.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import UIKit

public protocol RowType {
    var reuseIdentifier: String { get set }
    var height: CGFloat? { get set }
    var dynamicHeight: Bool { get set }
}

protocol RowDelegateType {
    func configure(_ cell: UITableViewCell)
}
