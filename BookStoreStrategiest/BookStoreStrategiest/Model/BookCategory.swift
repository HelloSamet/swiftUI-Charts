//
//  BookCategory.swift
//  BookStoreStrategiest
//
//  Created by Abdulsamet Göçmen on 14.11.2024.
//

import Foundation

enum BookCategory: Identifiable, CaseIterable {
    case fiction
    case biography
    case children
    case computerScience
    case fantasy
    case business
    
    var id: Self { return self }
    
    var displayName: String {
        switch self {
        case .fiction: return "Fiction"
        case .biography: return "Biography"
        case .children: return "Children"
        case .computerScience: return "Computer Science"
        case .fantasy: return "Fantasy"
        case .business: return "Business"
        }
    }
}
