//
//  TableViewController.swift
//  RxCocoaTest
//
//  Created by Sahil Dhawan on 08/01/18.
//  Copyright © 2018 Sahil Dhawan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: UITableViewController {
    
    private var viewModel : TableViewModel!
    
    let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: nil)
    let disposeBag = DisposeBag()
    let cellIdentifier = "Cell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItems()
        setupTableView()
        setupTableViewModel()
        setupTableViewBinding()
        self.navigationItem.title = "RxCocoa Test"
    }
    
    
    func setupTableView() {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func setupBarButtonItems() {
        self.navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    private func setupTableViewModel(){
        self.viewModel = TableViewModel(addDriver: addButton.rx.tap.asDriver())
    }
    
    private func setupTableViewBinding() {
        viewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)){row,element,cell in
            cell.textLabel?.text = "\(element) \(row)"
            }.disposed(by: disposeBag)
    }
}
