//
//  EditExpenseViewModel.swift
//  NoExpense
//
//  Created by Aashish Tamsya on 19/07/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import RxSwift
import Action

struct EditExpenseViewModel {
  let amount: String
  let onUpdate: Action<String, Void>!
  let onCancel: CocoaAction?
  let disposeBag = DisposeBag()
  
  init(transaction: TransactionItem, coordinator: SceneCoordinatorType, updateAction: Action<String, Void>, cancelAction: CocoaAction? = nil) {
    amount = transaction.amount
    onUpdate = updateAction
    
    onUpdate.executionObservables
      .take(1)
      .subscribe { _ in
        coordinator.pop()
      }
      .disposed(by: disposeBag)
    
    onCancel = CocoaAction {
      if let cancelAction =  cancelAction {
        cancelAction.execute()
      }
      return coordinator.pop()
        .asObservable()
        .map { _ in }
    }
  }
}
