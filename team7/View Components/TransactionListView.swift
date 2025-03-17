//
//  TransactionListView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var billViewModel: BillObjectModel
    
    var body: some View {
        Text("Transaction")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title)
            .fontWeight(.bold)

        List(billViewModel.bills, id: \.id) { bill in
            HStack {
                VStack(alignment: .leading) {
                    Text(bill.name)
                        .fontWeight(.bold)
                    Text(bill.price, format: .currency(code: "IDR"))
                }
                
                Spacer()
                
                Image(systemName: "checkmark")
                    .foregroundColor(Color.blue)
                    .fontWeight(.bold)
                
            }
            .listRowInsets(EdgeInsets())
            .padding(.vertical)
            .padding(.horizontal, 8)
        }
        .listStyle(PlainListStyle())
        .padding(.horizontal, 0)

        HStack {
            Image(systemName: "plus")
            Text("Add Additional Fee")
        }
        .foregroundColor(.blue)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
