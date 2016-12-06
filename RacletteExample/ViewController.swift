//
//  ViewController.swift
//  RacletteExample
//
//  Created by Roman Blum on 15.11.16.
//  Copyright © 2016 RMNBLM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.register(CustomCell.self)

        var firstSection = tableView.addSection()
        firstSection.headerTitle = "First Section Header"
        firstSection.footerTitle = "First Section Footer"

        let row1 = Row()
        row1.configuration = { cell in
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Pinterest cred put a bird on it, meggings blue bottle pop-up la croix pok pok narwhal drinking vinegar hammock man bun VHS tofu freegan. Typewriter marfa tacos, viral lomo narwhal lyft farm-to-table subway tile wolf cold-pressed fam whatever fingerstache. Squid pickled kombucha you probably haven't heard of them neutra. Brooklyn taxidermy cray, helvetica venmo vinyl pop-up green juice pug. Fingerstache aesthetic poke, succulents keytar hammock man braid quinoa narwhal kickstarter drinking vinegar activated charcoal occupy fam stumptown. Ramps tattooed meh fam, freegan gastropub keytar gochujang fanny pack seitan tumblr 3 wolf moon gentrify. Skateboard beard humblebrag woke, swag cornhole kitsch everyday carry sartorial dreamcatcher retro." // Hipster Ipsum
        }
        
        firstSection.addRow(row1)

        firstSection.createRow { row in
            row.height = 200
            row.configuration = { cell in
                cell.textLabel?.text = "Second Row in First Section with a static height of 200"
            }
        }
        firstSection.createRow { row in
            row.configuration = { cell in
                cell.textLabel?.text = "Overrides the global isRowHighlightingEnabled setting. You can touch me. :)"
            }
            row.shouldHighlight = { cell, _ in
                return true
            }
            row.didSelect = { cell, tableInfo in
                cell.textLabel?.text = "Selected"
                tableInfo.tableView.deselectRow(at: tableInfo.indexPath, animated: true)
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
            row.configuration = { cell in
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = "This row will be automatically added to the the second section"
            }
        }

        tableView.isRowHighlightingEnabled = false
    }
}

