//
//  AssignBillView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct AssignBillView: View {
    
    @ObservedObject var personViewModel: PersonObjectModel
    @ObservedObject var billViewModel: BillObjectModel
    
    
    @State private var isAddTransactionPresented: Bool = false
    @State private var search: String = ""
    
    var body: some View {
        VStack {
            
            // People
            TitleView(text: "Bill Title")
            
            // Search bar
            SearctBarView(search: $search)
            
            // List Person
            PeopleListView(personViewModel: personViewModel)
            Spacer()
            
            // transaction list
            TransactionListView(billViewModel: billViewModel)
            Spacer()

            HStack {
                Button(action: {
                    isAddTransactionPresented = true
                }){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .safeAreaPadding(.all)
        .sheet(isPresented: $isAddTransactionPresented, content: {
            AddBillView(billViewModel: billViewModel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
    }
}


#Preview {
    AssignBillView(personViewModel: PersonObjectModel(), billViewModel: BillObjectModel())
}
