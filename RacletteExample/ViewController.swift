//
//  ViewController.swift
//  RacletteExample
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import UIKit
import Raclette

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")

        let row1 = Row()
        row1.dynamicHeight = true
        row1.configuration = { cell in
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Text Label Text Label Text Label Text Label Text Label Text Label Text Label Text Label Text Label Text Label "
        }

        tableView.raclette.addRow(row1)

        let row2 = Row<CustomCell>()
        row2.height = 200
        row2.configuration = { cell in
            cell.textLabel?.text = "Text Label"
        }
        
        tableView.raclette.addRow(row2)
    }
}

