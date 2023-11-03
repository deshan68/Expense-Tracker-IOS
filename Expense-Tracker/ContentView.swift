//
//  ContentView.swift
//  Expense-Tracker
//
//  Created by arun deshan on 2023-11-03.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var demoData: [(Double, Double)] = [
        (10.6,20.3),
        (10.0,11.0),
        (10.6,20.3),
        (10.0,11.0),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Mark : Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //Mark: Chart
                    let data = transactionListVM.accumilateTransaction()
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        VStack(alignment: .leading){
                            Text(totalExpenses.formatted(.currency(code: "USD")))
                                .font(.title)
                                .bold()
                                .padding()
                            LineChart()
                                .data(data)
                                .chartStyle(ChartStyle(backgroundColor: Color(UIColor.systemBackground), foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                                .frame(height: 300)
                        }
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    
                    //Mark: Transaction List
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
