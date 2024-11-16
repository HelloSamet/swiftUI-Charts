//
//  SalesPerBookCategoryHeaderView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 16.11.2024.
//

import SwiftUI

struct SalesPerBookCategoryHeaderView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        HStack{
            if let bestSellingCategory = salesViewModel.bestSellingCategory {
                Text("Your best selling category is ") +
                Text("\(bestSellingCategory.category.displayName)").bold()
                    .foregroundStyle(Color.accentColor) +
                Text(" with ") +
                Text("\(bestsellingCategoryPercentage ?? "")").bold() +
                Text(" of total sales.")
            }
           
        }
    }
    
    var bestsellingCategoryPercentage: String? {
        guard let bestSellingCategory = salesViewModel.bestSellingCategory else { return nil }
        
        let percentage = Double(bestSellingCategory.sales) / Double(salesViewModel.totalSales)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else { return nil }
        
        return formattedPercentage
        
    }
}

#Preview {
    SalesPerBookCategoryHeaderView(salesViewModel: SalesViewModel.preview)
}
