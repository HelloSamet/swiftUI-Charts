//
//  SalesByWeekdayHeaderView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 15.11.2024.
//

import SwiftUI

struct SalesByWeekdayHeaderView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        if let highestSellingWeekDay = salesViewModel.highestSellingWeekDay {
            Text("Your highest selling day of the week is ") +
            Text("\(weekday(for: highestSellingWeekDay.number)) ").bold()
                .foregroundColor(Color.accentColor) +
            Text(" with an average of ") +
            Text("\(Int(highestSellingWeekDay.sales)) sales per day.").bold()
        }
    }
    
    let formatter = DateFormatter()
    
    func weekday(for number: Int) -> String {
        formatter.weekdaySymbols[ number - 1 ]
    }
}

#Preview {
    SalesByWeekdayHeaderView(salesViewModel: SalesViewModel.preview)
}
