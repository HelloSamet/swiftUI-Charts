//
//  Expense.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 14.11.2024.
//

import Foundation

struct Expense: Identifiable {
    
    let id: UUID = UUID()
    let title: String
    let category: ExpenseCategory
    let amount: Double
    let expenseDate: Date
    
    static var example: Expense {
        Expense(title: "Rent", category: .fixed, amount: 2000, expenseDate: Date(timeIntervalSinceNow: -7_200_000))
    }
    
    static var examples: [Expense] = [
        Expense(title: "Rent", category: .fixed, amount: 2000, expenseDate: Date(timeIntervalSinceNow: -7_200_000)),
        Expense(title: "Electricity", category: .variable, amount: 150, expenseDate: Date(timeIntervalSinceNow: -5_200_000)),
        Expense(title: "Groceries", category: .variable, amount: 300, expenseDate: Date(timeIntervalSinceNow: -3_200_000)),
        Expense(title: "Internet", category: .fixed, amount: 60, expenseDate: Date(timeIntervalSinceNow: -2_500_000)),
        Expense(title: "Transportation", category: .variable, amount: 100, expenseDate: Date(timeIntervalSinceNow: -1_800_000)),
        Expense(title: "Gym Membership", category: .fixed, amount: 50, expenseDate: Date(timeIntervalSinceNow: -1_200_000)),
        Expense(title: "Dining Out", category: .variable, amount: 75, expenseDate: Date(timeIntervalSinceNow: -900_000))
    ]
    
    static var yearExample: [Expense] = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        var expenses = [Expense]()
        
        for month in 1...12 {
            for _ in 1...10 {
                let randomDay = Int.random(in: 1...28)
                let date = formatter.date(from: "2024/\(month)/\(randomDay)")!
                let category: ExpenseCategory = Bool.random() ? .fixed : .variable
                let title = category == .fixed ? "Rent" : "Supplies"
                let amount: Double = category == .fixed ? 2000 : Double.random(in: 100...500)
                expenses.append(Expense(title: title, category: category, amount: amount, expenseDate: date))
            }
        }
        return expenses
    }()
        
}


enum ExpenseCategory {
    case fixed
    case variable
    
    var displayName: String {
        switch self {
        case .fixed: return "Fixed"
        case .variable: return "Variable"
        }
    }
}
