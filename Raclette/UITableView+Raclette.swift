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
    public var raclette: Raclette {
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
}
