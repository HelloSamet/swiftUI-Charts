//
//  ContentView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 14.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var salesViewModel = SalesViewModel.preview
    @StateObject var expensesViewModel = ExpensesViewModel.preview
    var body: some View {
        NavigationStack{
            List{
                
                Section{
                    NavigationLink{
                        DetailBookSalesView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleBookSalesView(salesViewModel: salesViewModel)
                    }
                }
                
                Section{
                    NavigationLink{
                        SalesByWeekDayView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleSalesByWeekDayView(salesViewModel: salesViewModel)
                    }
                }
                
                Section{
                    NavigationLink{
                        SalesPerBookCategoryView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleSalesPerBookCategoryView(salesViewModel: salesViewModel)
                    }
                }
                
                Section{
                    NavigationLink{
                        DetailExpensesView(expensesViewModel: expensesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleExpensesLineChartView(expensesViewModel:expensesViewModel)
                    }
                }
                
            }.navigationTitle("Your Book store Stats")
        }
    }
}

#Preview {
    ContentView()
}
