//
//  TransactionList.swift
//  Expense-Tracker
//
//  Created by arun deshan on 2023-11-03.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel

    var body: some View {
        VStack {
            List {
                //Mark : Transactoin group
                ForEach(Array(transactionListVM.groupTransactionByMonth()), id: \.key) { month, transactions in
                    Section {
                        //Mark : Transaction list
                        ForEach(transactions) { transaction in TransactionRow(transaction: transaction)}
                    } header: {
                        //Mark: Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NavigationView {
//        TransactionList()
//    }
//}

struct TransactionList_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transations = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        
        NavigationView {
            TransactionList()
                .environmentObject(transactionListVM)
        }
    }
    
}
