//
//  SimpleExpensesLineChartView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 17.11.2024.
//

import SwiftUI
import Charts

struct SimpleExpensesLineChartView: View {
    
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    let linearGradient = LinearGradient(colors: [Color.pink.opacity(0.7), Color.pink.opacity(0.3)], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Your totatl expenses for the last year are ") +
            Text("\(String(format: "%.2f", expensesViewModel.totalExpenses))")
                .bold()
                .foregroundColor(.pink)
            
            Chart(expensesViewModel.monthleyExpeseData) {
                data in
                
                AreaMark(x: .value("month", data.month), y: .value("expenses", data.totalExpenses))
                    .foregroundStyle(linearGradient)
                
            }.frame(height: 70)
                .chartXScale(domain: 1...12)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
        }
    }
}

#Preview {
    SimpleExpensesLineChartView(expensesViewModel: ExpensesViewModel.preview).padding()
}
