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
}
