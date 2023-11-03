//
//  TransactionRow.swift
//  Expense-Tracker
//
//  Created by arun deshan on 2023-11-03.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            //Mark: Transaction category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: .icons), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                //Mark : Transaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //Mark : transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //Mark : Transaction dat
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
            }
            Spacer()
            
            //Mark : Transaction amount
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundStyle(transaction.type == TransactionType.credit.rawValue ? .primary : Color.text )
        }
        .padding([.top, .bottom], 8)
    }
}

#Preview {
    TransactionRow(transaction: transactionPreviewData)
}
