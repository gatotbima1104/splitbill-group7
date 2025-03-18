//
//  TransactionListView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var billViewModel: BillObjectModel
    @State private var selectedBills: Set<UUID> = []
    @State private var isAddPersonViewPresented: Bool = false
    
    // Function to toggle selection state
       private func toggleBillSelection(_ id: UUID) {
           if selectedBills.contains(id) {
               selectedBills.remove(id) // Uncheck
           } else {
               selectedBills.insert(id) // Check
           }
       }
    
    var body: some View {
        
        VStack {
         
            // Custom fontWeight
            HStack {
                Text("Transaction")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                
                Button(action: {
                    isAddPersonViewPresented = true
                }){
                    Image(systemName: "plus")
                        .padding(.all, 5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                    
                
            }

            List(billViewModel.bills, id: \.id) { bill in
                HStack {
                    
                    Image(systemName: !selectedBills.contains(bill.id) ? "circle" : "checkmark.circle.fill")
                        .foregroundColor(!selectedBills.contains(bill.id) ? Color.gray : Color.green)
                        .fontWeight(.regular)
                        .font(.title2)
                    
                    VStack(alignment: .leading) {
                        Text(bill.name)
                            .font(.callout)
                            .fontWeight(.medium)
                        Text(bill.price, format: .currency(code: "IDR"))
                            .font(.footnote)
                            .fontWeight(.regular)
    //                        .foregroundColor(Color(.systemGray))
                    }
                    .padding(.horizontal, 5)
                    
                    Spacer()
    //

                    
                }.onTapGesture {
                    toggleBillSelection(bill.id)
                }
                .padding(.vertical)
    //            .padding(.horizontal)
    //            .background(Color.gray.opacity(0.1))
                .listRowInsets(EdgeInsets())
                
    //            .padding(.horizontal, 8)
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 0)

            HStack {
                Image(systemName: "plus")
                Text("Add Additional Fee")
                    .font(.footnote)
                    .fontWeight(.regular)
            }
            .foregroundColor(.blue)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }.sheet(isPresented: $isAddPersonViewPresented){
            AddBillView(billViewModel: billViewModel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}
