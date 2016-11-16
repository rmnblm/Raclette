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
            guard let racletteInstance = self.layer.value(forKey: instanceKey) as? Raclette else {
                let instance = Raclette(self)
                self.layer.setValue(instance, forKey: instanceKey)
                return instance
            }
            return racletteInstance
        }
    }
}
