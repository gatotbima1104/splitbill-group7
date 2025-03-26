//
//  Person.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import Foundation
import SwiftUI

struct PersonModel: Identifiable, Codable  {
    var id: UUID = UUID()
    var name: String
    var isPaid : Bool = false
    var paymentMethod: String?
    var paymentNumber: Int?
    var createdAt: Date = Date()
    var bills: [BillModel] = []
    
    var color: Color {
        return PersonModel.colorForName(id.uuidString)
    }
    
    private static func colorForName(_ name: String) -> Color {
        let colors: [Color] = [.red, .blue, .green, .orange, .purple, .pink, .yellow]
        let hashValue = abs(name.hashValue) % colors.count // Ensure positive Int
        return colors[hashValue]
    }}
