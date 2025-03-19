//
//  AddAdditionaFeeView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI

struct AddAdditionaFeeView: View {
    
    @State private var newTax: String = ""
    @State private var newAdditionalFee: String = ""
    
    @ObservedObject var billViewModel: BillObjectModel
    @Environment(\.dismiss) var dismiss // Used to close the sheet
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("%", text: $newTax)
                        .keyboardType(.decimalPad)
                        .autocorrectionDisabled()
                } header: {
                    Text("Enter The Tax %")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
                
                Section {
                    TextField("Additional Fee", text: $newAdditionalFee)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Enter The Fee")
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
                        dismiss()
                    }
                }
            }
        }
    }
}

