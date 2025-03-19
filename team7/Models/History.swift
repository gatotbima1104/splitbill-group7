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
    var total: Double
    var people: [PersonModel]
    var bills: [BillModel]
    var paymentMethod: String?
    var paymentNumber: String?
}
