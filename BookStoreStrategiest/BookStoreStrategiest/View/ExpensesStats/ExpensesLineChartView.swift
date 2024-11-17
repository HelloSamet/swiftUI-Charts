//
//  ExpensesLineChartView.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 17.11.2024.
//

import SwiftUI
import Charts

struct ExpensesLineChartView: View {
    
    @ObservedObject var expensesViewModel: ExpensesViewModel
    let symbolSize: CGFloat = 100
    let lineWidth: CGFloat = 2
    
    let linearGradient = LinearGradient(colors: [Color.cyan.opacity(0.2), Color.cyan.opacity(0)], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        Chart(expensesViewModel.monthleyExpeseData) {
            data in
            
            Plot{
                
                LineMark(x: .value("month", data.month),
                          y: .value("expenses", data.fixedExpenses))
                    .foregroundStyle(by: .value("Expenses", "fixed"))
                    .symbol(by: .value("Expenses", "fixed"))
                /*
                AreaMark(x: .value("month", data.month),
                         y: .value("expenses", data.fixedExpenses))
                .foregroundStyle(linearGradient)
                
              */
                
                LineMark(x: .value("month", data.month),
                          y: .value("expenses", data.variableExpense))
                    .foregroundStyle(by: .value("Expenses", "variable"))
                    .symbol(by: .value("Expenses", "variable"))
                 
                
            }
            .lineStyle(StrokeStyle(lineWidth: lineWidth))
            .interpolationMethod(.catmullRom)
            
        }
        .aspectRatio(1, contentMode: .fit)
        .chartForegroundStyleScale(["variable": .purple,
                                      "fixed": .cyan])
        .chartSymbolScale([
            "variable": Circle().strokeBorder(lineWidth: lineWidth),
             "fixed": Square().strokeBorder(lineWidth: lineWidth)
            ])
        .chartXScale(domain: 0...13)
        .chartYAxis {
            AxisMarks { value in
                AxisGridLine()
                AxisTick()
                if let number = value.as(Double.self) {
                    AxisValueLabel("\(Int(number / 1000)) K")
                }
            }
        }
    }
    
    let formatter = DateFormatter()
    
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
}

#Preview {
    ExpensesLineChartView(expensesViewModel: ExpensesViewModel.preview)
        .padding()
}

struct Square: ChartSymbolShape, InsettableShape {
    let inset: CGFloat
    
    init(inset: CGFloat = 0) {
        self.inset = inset
    }
    
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
            cornerRadius: cornerRadius
        )
    }
    
    func inset(by amount: CGFloat) -> Square {
        Square(inset: inset + amount)
    }
    
    var perceptualUnitRect: CGRect {
        // The width of the unit rectangle (square). Adjust this to
        // size the diamond symbol so it perceptually matches with
        // the circle.
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
    }
}
