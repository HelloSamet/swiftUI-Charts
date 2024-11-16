//
//  SalesViewModel.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 14.11.2024.
//

import Foundation

class SalesViewModel: ObservableObject {
    
    @Published var salesData = [Sale]()
    
    var totalSales: Int {
        salesData.reduce(0) { $0 + $1.quantity }
    }
    
    @Published var lastTotalSales: Int = 0
    
    var salesByWeek: [(day: Date, sales: Int)] {
        let salesByWeek = salesGroupedByWeek(sales: salesData)
        return totalSalesPerDate(salesByDate: salesByWeek)
    }
    
    var highestSellingWeekDay: (number: Int, sales: Double)? {
        averageSalesByWeekDay.max(by: { $0.sales < $1.sales })
    }
    
    var averageSalesByWeekDay: [(number: Int, sales: Double)] {
        let salesByWeekDay = salesGroupedByWeekDay(sales: salesData)
        let averageSales = averageSalesPerNumber(salesByNumber: salesByWeekDay)
        let sorted = averageSales.sorted { $0.number < $1.number }
        return sorted
    }
    
    var salesByWeekDay: [(number: Int, sales: [Sale])] {
        let salesByWeekDay = salesGroupedByWeekDay(sales: salesData).map {
            (number: $0.key, sales: $0.value)
        }
        return salesByWeekDay.sorted {  $0.number < $1.number }
    }
    
    var medianSales: Double {
        let salesData = self.averageSalesByWeekDay
        return calculateMedian(salesData: salesData) ?? 0
    }
    
    var totalSalesPerCategory: [(category: BookCategory, sales: Int)] {
        let salesByCategory = salesGroupedByCategory(sales: salesData)
        let totalSalesPerCategory = totalSalesPerCategory(salesByCategory: salesByCategory)
        return totalSalesPerCategory.sorted { $0.sales > $1.sales }
    }
    
    var bestSellingCategory: (category: BookCategory, sales: Int)? {
        totalSalesPerCategory.max { $0.sales < $1.sales }
    }
    
    
    func fetchSalesData() {
        salesData = Sale.threeMonthsExamples()
    }
    
    func salesGroupedByWeek(sales: [Sale]) -> [Date: [Sale]] {
        var salesByWeek: [Date: [Sale]] = [:]
        
        let calendar = Calendar.current
        for sale in sales {
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: sale.saleDate))
            else { continue }
            if salesByWeek[startOfWeek] != nil {
                salesByWeek[startOfWeek]!.append(sale)
            } else {
                salesByWeek[startOfWeek] = [sale]
            }
        }
        
        return salesByWeek
    }
    
    
    func totalSalesPerDate(salesByDate: [Date: [Sale]]) -> [(day: Date, sales: Int)] {
        var totalSales: [(day: Date, sales: Int)] = []
        
        for (date, sales) in salesByDate {
            let totalQuantityForDate = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((day: date, sales: totalQuantityForDate))
        }
        
        return totalSales
    }
    
    func salesGroupedByWeekDay(sales: [Sale]) -> [Int: [Sale]] {
        var salesByWeekDay: [Int: [Sale]] = [:]
        let calendar = Calendar.current
        
        for sale in sales {
            let weekDay = calendar.component(.weekday, from: sale.saleDate)
            if salesByWeekDay[weekDay] != nil {
                salesByWeekDay[weekDay]!.append(sale)
            } else {
                salesByWeekDay[weekDay] = [sale]
            }
        }
        
        return salesByWeekDay
    }
    
    func averageSalesPerNumber(salesByNumber: [Int: [Sale]]) -> [(number: Int, sales: Double)] {
        var averageSales: [(number: Int, sales: Double)] = []
        
        for (number, sales) in salesByNumber {
            let count = sales.count
            let totalQuantityForWeekDay = sales.reduce(0) { $0 + $1.quantity }
            averageSales.append((number: number, sales: Double(totalQuantityForWeekDay) / Double(count)))
        }
        
        return averageSales
    }
    
    func calculateMedian(salesData: [(number: Int, sales: Double)]) -> Double? {
        let quantities = salesData.map{ $0.sales }.sorted()
        let count = quantities.count
        
        if count % 2 == 0 {
            let middleIndex = count / 2
            let median = (quantities[middleIndex - 1] + quantities[middleIndex]) / 2
            return Double(median)
        }
        else {
            let middleIndex = count / 2
            return Double(quantities[middleIndex])
        }
    }
    
    // Category stats
    
    func salesGroupedByCategory(sales: [Sale]) -> [BookCategory: [Sale]] {
        var salesByCategory: [BookCategory: [Sale]] = [:]
        
        for sale in sales {
            if salesByCategory[sale.book.category] != nil {
                salesByCategory[sale.book.category]!.append(sale)
            } else {
                salesByCategory[sale.book.category] = [sale]
            }
        }
        
        return salesByCategory
    }
    
    func totalSalesPerCategory(salesByCategory: [BookCategory: [Sale]]) -> [(category: BookCategory, sales: Int)] {
        var totalSales: [(category: BookCategory, sales: Int)] = []
        
        for (category, sales) in salesByCategory {
            let totalQuantityForCategory = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((category: category, sales: totalQuantityForCategory))
        }
        
        return totalSales
    }
    
    static var preview: SalesViewModel {
        let vm = SalesViewModel()
        vm.salesData = Sale.higherWeekendThreeMonthsExamples
        vm.lastTotalSales = 500
        return vm
    }
}
