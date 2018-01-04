//
//  RepositoryListViewController.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  func registerNibs() {
    tableView.registerNib(cellClass: RepositoryTableViewCell.self)
  }
}
