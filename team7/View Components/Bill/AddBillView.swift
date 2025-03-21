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
                Section {
                    TextField("Name", text: $newBillName)
                        .autocorrectionDisabled()
                } header: {
                    Text("Enter The Name")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
                
                Section {
                    TextField("Price", text: $newBillPrice)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Enter The Price")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
            }.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss() // Dismiss the sheet
                    }
                }
                ToolbarItem(placement: .principal){
                    Text("Add Item Details")
                        .font(.title3)
                        .fontWeight(.semibold)
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

