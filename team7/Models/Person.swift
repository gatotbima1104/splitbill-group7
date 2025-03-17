//
//  Person.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import Foundation

struct PersonModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var paymentMethod: String?
    var paymentNumber: Int?
    var createdAt: Date = Date()
}
