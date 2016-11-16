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

        var firstSection = tableView.addSection()
        firstSection.headerTitle = "First Section Header"
        firstSection.footerTitle = "First Section Footer"

        let row1 = Row()
        row1.dynamicHeight = true
        row1.configuration = { cell in
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "This is a long-ass text which causes the cell to dynamically set the height of the row."
        }
        
        firstSection.addRow(row1)

        firstSection.createRow { row in
            row.height = 200
            row.configuration = { cell in
                cell.textLabel?.text = "Second Row in First Section with a static height of 200"
            }
        }

        var secondSection = tableView.createSection { section in
            section.headerTitle = "Second Section Header"
            section.createRow { (row: Row<CustomCell>) in
                row.configuration = { cell in
                    cell.textLabel?.text = "Text Label 2"
                }
            }
        }

        secondSection.footerTitle = "Second Section Footer"

        tableView.createRow { row in
            row.dynamicHeight = true
            row.configuration = { cell in
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = "This row will be automatically added to the the second section"
            }
        }
    }
}

