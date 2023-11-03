//
//  RecentTransactionList.swift
//  Expense-Tracker
//
//  Created by arun deshan on 2023-11-03.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            HStack {
                //Mark : Header Title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                //Mark : Header Link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            //Mark : Recent Transaction List
            ForEach(Array(transactionListVM.transations.prefix(5).enumerated()), id: \.element) { index, transaction in TransactionRow(transaction: transaction)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)    }
}

//#Preview {
//
//}

struct RecentTransactionList_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transations = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        
        RecentTransactionList()
            .environmentObject(transactionListVM)
    }
    
}

