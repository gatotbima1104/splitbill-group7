//
//  AddBillView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 18/03/25.
//


import SwiftUI

struct AddBillView: View {
    
    @State private var newBillName: String = ""
    @State private var newBillPrice: String = ""
    
    @ObservedObject var billViewModel: BillObjectModel
    @Environment(\.dismiss) var dismiss // Used to close the sheet
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $newBillName)
                    .autocorrectionDisabled()
                TextField("Price", text: $newBillPrice)
                    .keyboardType(.decimalPad)
            }.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss() // Dismiss the sheet
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        billViewModel.addBill(name: newBillName, price: Double(newBillPrice) ?? 0)
                        dismiss()
                    }
                    .disabled(newBillName.isEmpty || newBillPrice.isEmpty)
                }
            }
        }
    }
}

