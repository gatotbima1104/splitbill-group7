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
//        BillModel(name: "Es Teh", price: 5000),
//        BillModel(name: "Bakwan", price: 2000),
//        BillModel(name: "Tempe", price: 2000)
    ]
    
    @Published var searchText: String = ""
    
    func addBill(name: String, price: Double) {
        bills.append(BillModel(name: name, price: price))
    }
    
    // remove bills
    func removeBill(atOffset offsets: IndexSet) {
        bills.remove(atOffsets: offsets)
    }
    
    // Computed property to filter people based on searchText
    var filteredBills: [BillModel] {
        if searchText.isEmpty {
            return bills
        } else {
            return bills.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
