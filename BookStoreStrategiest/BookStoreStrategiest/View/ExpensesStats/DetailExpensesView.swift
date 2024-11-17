//
//  DetailExpensesView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 17.11.2024.
//

import SwiftUI

struct DetailExpensesView: View {
    @ObservedObject var expensesViewModel: ExpensesViewModel
    var body: some View {
        List {
            Group{
                Section{
                    ExpensesLineChartView(expensesViewModel: expensesViewModel)
                    
                }
                
                Section{
                    Text("Detailed Breakdown of Your Expenses per Mounth")
                        .bold()
                        .padding(.top, 30)
                    ExpensesDetailGridView(expensesViewModel: expensesViewModel)
                }
            }.listRowSeparator(.hidden)
                .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
            
        }.listStyle(.plain)
    }
}

#Preview {
    DetailExpensesView(expensesViewModel: .preview)
}
