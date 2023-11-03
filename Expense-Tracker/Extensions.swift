//
//  Extensions.swift
//  Expense-Tracker
//
//  Created by arun deshan on 2023-11-03.
//

import Foundation
import SwiftUI

//extension Color {
//    static let Background = Color("Background")
//    static let Icon = Color("Icon")
//    static let Text = Color("Text")
//    static let systemBackground = Color(uiColor: .systemBackground)
//}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("initializing dateformatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parseDare  = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        
        return parseDare
    }
}
