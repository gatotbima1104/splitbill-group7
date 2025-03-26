//
//  History.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import Foundation

struct HistoryModel: Identifiable, Codable  {
    var id: UUID = UUID()
    var name: String
    var createdAt: Date = Date()
//    var total: Double
    var people: [PersonModel]
    var bills: [BillModel]
    var paymentMethod: String?
    var paymentNumber: String?
    var additionalFee : Double = 0
    var taxPercentage : Double = 0
    
    // Computed property to calculate total bill amount
    func calculateTotal() -> Double {
           var amount = 0.0

           // Sum up all bills for each person
           for person in people {
               for bill in person.bills {
                   let taxMultiplier = 1 + (taxPercentage / 100)
                   amount += bill.price * taxMultiplier
               }
           }
           
           // Add additional fee
           amount += additionalFee
           
           return amount
       }
}
