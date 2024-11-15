//
//  MonthlyChartView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 14.11.2024.
//

import SwiftUI
import Charts

struct MonthlyChartView: View {
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData){ sale in
            BarMark(x: .value("Day", sale.saleDate, unit: .month), y: .value("Sales", sale.quantity))
//                .foregroundStyle(Color.blue.gradient)
        }
        .chartXAxis{
            AxisMarks {
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
            }
        }
        .chartYAxis(content: {
            AxisMarks(position: .leading){
                AxisGridLine()
                AxisValueLabel()
            }
        })
    }
}

#Preview {
    MonthlyChartView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
