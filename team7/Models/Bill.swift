//
//  Bill.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import Foundation

func formatToRupiah(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "id_ID") // Indonesian locale
    formatter.maximumFractionDigits = 0 // No decimals in Rupiah format
    return formatter.string(from: NSNumber(value: amount)) ?? "Rp 0"
}

struct BillModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var price: Double
    var createdAt: Date = Date()
}
