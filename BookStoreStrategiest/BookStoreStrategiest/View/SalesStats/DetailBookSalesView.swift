//
//  DetailBookSalesView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 15.11.2024.
//

import SwiftUI

struct DetailBookSalesView: View {
   
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        
        var id: Self { self }
    }
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State var selectedTimeInterval: TimeInterval = .day
    
    var body: some View {
        VStack(alignment: .leading){
            Picker(selection: $selectedTimeInterval.animation(), content: {
                ForEach(TimeInterval.allCases){ interval in
                    Text(interval.rawValue)
                }
            }, label: {
                Text("Time Interval for chart")
            }).pickerStyle(.segmented)
            Group{
                Text("You sold ") +
                Text("\(salesViewModel.totalSales) books").bold().foregroundColor(.accentColor) +
                Text(" in the last 90 days.")
            }.padding(.vertical)
            Group{
                switch selectedTimeInterval {
                case .day:
                    DailySalesChartView(salesData: salesViewModel.salesData)
                case .week:
                    WeeklyChartsView(salesViewModel: salesViewModel)
                case .month:
                    MonthlyChartView(salesData: salesViewModel.salesData)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            Spacer()
        }.padding()
    }
}

#Preview {
    DetailBookSalesView(salesViewModel: .preview)
}
