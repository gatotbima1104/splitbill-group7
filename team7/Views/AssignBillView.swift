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
                ButtonView(text: "Add", color: .blue){
                }
                Spacer ()
                ButtonView(text: "Next", color: .green){
                }
            }
            Spacer()
        }
        .safeAreaPadding(.all)
    }
}


#Preview {
    AssignBillView(personViewModel: PersonObjectModel(), billViewModel: BillObjectModel())
}
