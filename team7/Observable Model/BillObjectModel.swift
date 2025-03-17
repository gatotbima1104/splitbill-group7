//
//  BillObjectModel.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import Foundation

class BillObjectModel: ObservableObject {
    @Published var bills: [BillModel] = [
        BillModel(name: "Mie ayam", price: 8500),
        BillModel(name: "Bakso", price: 10000),
        BillModel(name: "Es Jeruk", price: 5000),
        BillModel(name: "Es Teh", price: 5000),
        BillModel(name: "Bakwan", price: 2000),
        BillModel(name: "Tempe", price: 2000)
    ]
    
    func addBill(name: String, price: Double) {
        bills.append(BillModel(name: name, price: price))
    }
}
