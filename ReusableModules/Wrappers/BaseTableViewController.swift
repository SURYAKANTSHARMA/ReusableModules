//
//  BaseTableViewController.swift
//  YoGrowcerCustomer
//
//  Created by Mac mini on 6/22/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        // add Constraints
        addContraintToTableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.hideEmptyCellSeprators()
        tableView.separatorStyle = .none
    }
    
    func addContraintToTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        } else {
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
   
    
}
