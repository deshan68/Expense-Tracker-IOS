//
//  TransactionListViewModel.swift
//  Expense-Tracker
//
//  Created by arun deshan on 2023-11-03.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup =  OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transations: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response) //it mean print the data more readable way
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions:", error)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transations = result
                dump(self?.transations)
            }
            .store(in: &cancellables)
        
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transations.isEmpty else { return [:] }
        
        let groupTransactions = TransactionGroup(grouping: transations) { $0.month }
        
        return groupTransactions
    }
    
    func accumilateTransaction() -> TransactionPrefixSum {
        print("accumilateTransaction")
        guard !transations.isEmpty else { return [] }
        
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
//        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transations.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digit()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "Dailytotal ", dailyTotal, "sum", sum)
            
        }
//        print("cumulativeSum", cumulativeSum)
        return cumulativeSum
        
    }
}
