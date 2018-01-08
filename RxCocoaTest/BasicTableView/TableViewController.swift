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

    //decalring view model of type table view model
    private var viewModel : TableViewModel!
    
    //add button to add new items
    let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: nil)
    
    //dipose bag to unallocate the space for rx components and prevent memory leaks
    let disposeBag = DisposeBag()
    
    //cell identifier for table view cell
    let cellIdentifier = "Cell"

    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItems()
        setupTableView()
        setupTableViewModel()
        setupTableViewBinding()
        setupCellTapHandling()
        self.navigationItem.title = "RxCocoa Test"
    }
    
    //declaring table view delegate and datasource to nil and registering for table view cells
    func setupTableView() {
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    // adding add bar button to navigation item
    func setupBarButtonItems() {
        self.navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    // creating an instance of table view model and passing add button as driver
    private func setupTableViewModel(){
        self.viewModel = TableViewModel(addDriver: addButton.rx.tap.asDriver())
    }
    
    //binding the data source of table view model to the cells of table view
    private func setupTableViewBinding() {
        viewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)){row,element,cell in
            cell.selectionStyle = .none
            cell.textLabel?.text = "\(element) \(row)"
            }
            .disposed(by: disposeBag)
    }
    
    // subscribing to item selection of table view
    private func setupCellTapHandling(){
        tableView
        .rx
        .itemSelected
            .subscribe({_ in
                let selectedIndex = self.tableView.indexPathForSelectedRow?.row
                print("Table View Row at Index \(String(describing: selectedIndex)) Selected")
            })
            .disposed(by : disposeBag)
    }
}


