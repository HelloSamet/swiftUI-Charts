//
//  SimpleBookSalesView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 15.11.2024.
//

import SwiftUI

struct SimpleBookSalesView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    var body: some View {
        if let changeBookSales = changeBookSales() {
            
            HStack(alignment: .firstTextBaseline){
                Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                    .foregroundColor(isPositiveChange ? .green : .red)
                Text("Your book sales ") +
                Text(changeBookSales)
                    .bold() +
                Text(" in the last 90 days")
            }
        }
        
        WeeklyChartsView(salesViewModel: salesViewModel)
            .frame(height: 70)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
    }
    
    var percentage: Double {
        Double(salesViewModel.totalSales) /
        Double(salesViewModel.lastTotalSales) - 1
    }
    
    var isPositiveChange: Bool { percentage > 0 }
    
    func changeBookSales() -> String? {
        let percentage = self.percentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formatterPercantage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changeDescription = percentage < 0 ? "decreased by " : "increased by"
        
        return changeDescription + formatterPercantage
    }
}

#Preview {
    SimpleBookSalesView(salesViewModel: SalesViewModel.preview)
        .padding()
}


#Preview("Negative"){
    @Previewable let decreasedVM = SalesViewModel.preview
    decreasedVM.lastTotalSales = 15
    
    return SimpleBookSalesView(salesViewModel: decreasedVM)
        .padding()
}
