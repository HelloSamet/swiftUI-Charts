//
//  SimpeSalesPerBookCategoryView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 16.11.2024.
//

import SwiftUI
import Charts

struct SimpleSalesPerBookCategoryView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        HStack{
            SalesPerBookCategoryHeaderView(salesViewModel: salesViewModel)
            
            Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
                SectorMark(angle: .value("Book Category", data.sales),
                           innerRadius: .ratio(0.618),
                           angularInset: 1.5)
                .cornerRadius(5)
                .opacity(salesViewModel.bestSellingCategory?.category == data.category ? 1 : 0.3)
            }.aspectRatio(1, contentMode: .fit)
            .frame(height: 70)
        }
    }
}

#Preview {
    SimpleSalesPerBookCategoryView(salesViewModel: SalesViewModel.preview)
        .padding()
}
