//
//  SalesPerBookCategoryView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 16.11.2024.
//

import SwiftUI

struct SalesPerBookCategoryView: View {
    
    enum ChartStyle: CaseIterable, Identifiable {
        case pie
        case bar
        
        var id: Self { self }
        
        var displayName: String {
            switch self {
            case .pie: return "Pie Chart"
            case .bar: return "Bar Chart"
            }
        }
    }
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var selectedChartType: ChartStyle = .pie
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Picker("Chart Type", selection: $selectedChartType.animation()) {
                ForEach(ChartStyle.allCases) { chartType in
                    Text(chartType.displayName).tag(chartType)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            SalesPerBookCategoryHeaderView(salesViewModel: salesViewModel)
            
            switch selectedChartType {
            case .pie:
                SalesPerBookCategoryPieChartView(salesViewModel: salesViewModel)
            case .bar:
                SalesPerBookCategoryBarChartView(salesViewModel: salesViewModel)
            }
            
            Button(action: {
                withAnimation(.bouncy) {
                    salesViewModel.fetchSalesData()
                }
            }, label: {
                Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
            }).frame(maxWidth: .infinity)
                .padding(30)
            
            Spacer()
            
        }.padding()
    }
}

#Preview {
    SalesPerBookCategoryView(salesViewModel: SalesViewModel.preview)
}
