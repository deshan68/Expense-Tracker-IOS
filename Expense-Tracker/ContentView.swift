//
//  ContentView.swift
//  Expense-Tracker
//
//  Created by arun deshan on 2023-11-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Mark : Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //Mark : Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundColor(Color.icon)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transations = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        
        ContentView()
            .environmentObject(transactionListVM)
    }
    
}
