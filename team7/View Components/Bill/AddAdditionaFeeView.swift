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
                    Text("Tax")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
                
                Section {
                    TextField("Rp", text: $newAdditionalFee)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Others")
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
                    Text("Additional Fee")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        billViewModel.additionalFee = Double(newAdditionalFee) ?? 0
                        billViewModel.taxPercentage = Double(newTax) ?? 0
                        dismiss()
                    }
                }
            }
        }.onAppear {
            if(billViewModel.additionalFee > 0){
                newAdditionalFee = billViewModel.additionalFee.description
            }
            
            if(billViewModel.taxPercentage > 0){
                newTax = billViewModel.taxPercentage.description
            }
        }
    }
}

#Preview {
    AddAdditionaFeeView(billViewModel: .init())
}


