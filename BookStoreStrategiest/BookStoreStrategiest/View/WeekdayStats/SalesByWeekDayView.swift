//
//  SalesByWeekDayView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 15.11.2024.
//

import SwiftUI
import Charts

struct SalesByWeekDayView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    @State private var medianSalesIsShow = true
    @State private var individualDaysAreShown = false
    
    var body: some View {
        VStack(alignment: .leading){
            
            SalesByWeekdayHeaderView(salesViewModel: salesViewModel)
            
            Chart{
                ForEach(salesViewModel.averageSalesByWeekDay, id: \.number) {
                    BarMark(x: .value("Weekday", weekday(for: $0.number)), y: .value("average sales", $0.sales))
                        .foregroundStyle(Color.gray.gradient)
                        .opacity(0.3)
                    
                    RectangleMark(x: .value("Weekday", weekday(for: $0.number))
                                  , y: .value("average sales", $0.sales)
                                  , height: 3)
                    .foregroundStyle(.gray)
                    
                    if medianSalesIsShow {
                        RuleMark(y: .value("median sales", salesViewModel.medianSales))
                            .foregroundStyle(.indigo)
                            .annotation(position: .top, alignment: .trailing) {
                                Text("Median: \(salesViewModel.medianSales, specifier: "%.2f")")
                                    .font(.body.bold())
                                    .foregroundStyle(.indigo)
                            }
                    }
                    
                    
                    if individualDaysAreShown {
                        ForEach(salesViewModel.salesByWeekDay, id: \.number) { weekdayData in
                            ForEach(weekdayData.sales) { sale in
                                PointMark(x: .value("day", weekday(for: weekdayData.number)), y: .value("sales", sale.quantity))
                                    .opacity(0.3)
                            }
                        }
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
            
            Toggle(individualDaysAreShown ? "Show all daily sales" : "Hide daily sales" , isOn: $individualDaysAreShown.animation())
            Toggle(medianSalesIsShow ? "Show median sales" : "Hide median sales" , isOn: $medianSalesIsShow.animation())
            
            Spacer()
            
        }.padding()
    }
    
    let formatter = DateFormatter()
    
    func weekday(for number: Int) -> String {
        formatter.shortWeekdaySymbols[ number - 1 ]
    }
}

#Preview {
    SalesByWeekDayView(salesViewModel: SalesViewModel.preview)
}
