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
  func shouldHighlight(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) -> Bool?
  func didHighlight(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)
  func didUnhighlight(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)
  func willSelect(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) -> IndexPath?
  func willDeselect(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) -> IndexPath?
  func didSelect(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)
  func didDeselect(_ tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)
}

