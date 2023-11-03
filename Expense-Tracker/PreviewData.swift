//
//  PreviewData.swift
//  Expense-Tracker
//
//  Created by arun deshan on 2023-11-03.
//

import Foundation

var transactionPreviewData = Transaction(
    id: 1,
    date: "01/24/2023",
    institution: "Example Institute",
    account: "Example Account",
    merchant: "Apple",
    amount: 100.0,
    type: "credit", // Replace with the appropriate value from TransactionType.RawValue
    categoryId: 1,
    category: "Software",
    isPending: false,
    isTransfer: false,
    isExpense: true,
    isEdited: false
)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
 
