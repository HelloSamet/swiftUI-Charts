//
//  WeeklyChartsView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 14.11.2024.
//

import SwiftUI
import Charts

struct WeeklyChartsView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var rawSelectedDate: Date? = nil
    @Environment(\.calendar) var calendar
    
    var selectedDateValue: (day: Date, sales: Int)? {
        if let rawSelectedDate {
            return salesViewModel.salesByWeek.first {
                let startOfWeek = $0.day
                let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) ?? Date()
                
                return(startOfWeek...endOfWeek).contains(rawSelectedDate)
            }
        }
        else{
            return nil
        }
    }
    var body: some View {
        Chart{
            ForEach(salesViewModel.salesByWeek, id: \.day){ saleDate in
                BarMark(x: .value("Week", saleDate.day, unit: .weekOfYear), y: .value("Sales", saleDate.sales))
                    .foregroundStyle(Color.blue.gradient)
                    .opacity(selectedDateValue?.day == nil || selectedDateValue?.day == saleDate.day ? 1 : 0.5)
            }
            
            if let rawSelectedDate {
                RuleMark(x: .value("Selected Date", rawSelectedDate, unit: .day))
                    .foregroundStyle(.gray.opacity(0.3))
                    .zIndex(-1)
                    .annotation(position: .topTrailing, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)){
                        selectionPopover
                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
    }
    
    @ViewBuilder
    var selectionPopover: some View {
        if let selectedDateValue {
            VStack{
                Text(selectedDateValue.day.formatted(.dateTime.month()))
                Text("\(selectedDateValue.sales) sales")
            }
            .padding(6)
            .background
            {
                RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .shadow(color: .blue, radius: 2)
            }
            
        }
    }
}

struct PlainDataWeeklyChartsView: View {
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData){ sale in
            BarMark(x: .value("Week", sale.saleDate, unit: .weekOfYear), y: .value("Sales", sale.quantity))
//                .foregroundStyle(Color.blue.gradient)
        }
    }
}

#Preview {
    PlainDataWeeklyChartsView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

#Preview("Plain") {
    WeeklyChartsView(salesViewModel: SalesViewModel.preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
