//
//  SectionType.swift
//  Raclette
//
//  Created by Roman Blum on 16.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import Foundation

public protocol SectionType {
    var rows: [RowType] { get }
    var headerTitle: String? { get set }
    var footerTitle: String? { get set }
    func addRow(_ row: RowType?) -> RowType
}
