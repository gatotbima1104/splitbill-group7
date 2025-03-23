//
//  Bill.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import Foundation

struct BillModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var price: Double
    var createdAt: Date = Date()
}
