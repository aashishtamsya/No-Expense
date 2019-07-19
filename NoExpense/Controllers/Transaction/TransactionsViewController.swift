//
//  TransactionsViewController.swift
//  NoExpense
//
//  Created by Aashish Tamsya on 19/07/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action
import NSObject_Rx

final class TransactionsViewController: ViewController, BindableType {
  
  @IBOutlet weak fileprivate var tableView: UITableView!
  @IBOutlet weak fileprivate var newTransactionButton: UIBarButtonItem!
  
  var viewModel: TransactionsViewModel!
  var dataSource: RxTableViewSectionedAnimatedDataSource<TransactionSection>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
    
    configureDatasource()
  }
  
  func bindViewModel() {
    viewModel.sectionItems
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: rx.disposeBag)
    
    newTransactionButton.rx.action = viewModel.onCreateTransaction()
  }
  
  fileprivate func configureDatasource() {
    dataSource = RxTableViewSectionedAnimatedDataSource<TransactionSection>(configureCell: { _, tableView, indexPath, item in
      let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
      cell.configure(with: item)
      return cell
    })
    
  }
}
