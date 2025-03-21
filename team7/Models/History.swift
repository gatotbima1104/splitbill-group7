//
//  History.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import Foundation

struct HistoryModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var createdAt: Date = Date()
//    var total: Double
    var people: [PersonModel]
    var bills: [BillModel]
    var paymentMethod: String?
    var paymentNumber: String?
    
    // Computed property to calculate total bill amount
    var total: Double {
        people.reduce(0) { total, person in
            total + person.bills.reduce(0) { $0 + $1.price }
        }
    }
}
