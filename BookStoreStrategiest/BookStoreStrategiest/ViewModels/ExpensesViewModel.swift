//
//  ExpensesViewModel.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 16.11.2024.
//

import Foundation
import Combine

class ExpensesViewModel: ObservableObject {
    
    @Published private var expenses: [Expense] = []
    
    @Published var monthleyExpeseData: [ExpensesState] = []
    @Published var totalExpenses: Double = 0
    
    var subbscriptions: Set<AnyCancellable> = []
    
    init() {
        $expenses.sink { [unowned self] expenses in
            let fixedExpenses = self.expensesByMonth(category: .fixed, expenses: expenses)
            let variableExpenses = self.expensesByMonth(category: .variable, expenses: expenses)
            
            self.monthleyExpeseData = self.calculateTotalMonthleyExpenses(fixedExpenses: fixedExpenses,
                                                                          variableExpenses: variableExpenses)
            
            self.totalExpenses = calculateTotalE(for: expenses)
        }.store(in: &subbscriptions)
    }
    
    func expensesByMonth( category: ExpenseCategory, expenses: [Expense]) -> [(month: Int, amount: Double)] {
        let calendar = Calendar.current
        var expenseByMonth: [Int: Double] = [:]
        
        for expense in expenses where expense.category == category {
            let mounth = calendar.component(.month, from: expense.expenseDate)
            expenseByMonth[mounth, default: 0] += expense.amount
        }
        
        let result = expenseByMonth.map { (month: $0.key, amount: $0.value) }
        return result.sorted(by: { $0.month < $1.month })
    }
    
    func calculateTotalMonthleyExpenses(fixedExpenses: [(month: Int, amount: Double)],
                                            variableExpenses: [(month: Int, amount: Double)]) -> [ExpensesState] {
        var result: [ExpensesState] = []
        let count = min(fixedExpenses.count, variableExpenses.count)
        
        for index in 0..<count {
            let mounth = fixedExpenses[index].month
            result.append(ExpensesState(month: mounth,
                                        fixedExpenses: fixedExpenses[index].amount,
                                        variableExpense: variableExpenses[index].amount))
        }
        
        return result
    }
    
    func calculateTotalE(for expenses: [Expense]) -> Double {
        let totalExpenses = expenses.reduce(0) { total, expense in
                total + expense.amount
        }
        return totalExpenses
    }
    
    static var preview: ExpensesViewModel {
        let vm = ExpensesViewModel()
        vm.expenses = Expense.yearExamples
        return vm
    }
}

struct ExpensesState: Identifiable {
    let month: Int
    let fixedExpenses: Double
    let variableExpense: Double
    
    var totalExpenses: Double {
        fixedExpenses + variableExpense
    }
    
    var id: Int {
        return month
    }
}
