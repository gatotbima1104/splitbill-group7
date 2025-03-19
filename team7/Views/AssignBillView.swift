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

    var body: some View {
        NavigationStack {
            VStack {
                
                // People
                TitleView(text: "Bill Title")
                
                VStack {
                    // Search bar
                    SearctBarView(search: $personViewModel.searchText)
                    
                    // List Person
                    PeopleListView(personViewModel: personViewModel)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                
                Spacer()
                
                // transaction list
                TransactionListView(billViewModel: billViewModel, personViewModel: personViewModel)
                
                Spacer()

                NavigationLink (destination: SplitBillView()) {
                    Button(action: {
                      }){
                      Text("Next")
                          .frame(maxWidth: .infinity)
                          .padding()
                          .background(Color("Blue"))
                          .foregroundColor(.white)
                          .cornerRadius(10)
                      }
                      .allowsHitTesting(false)
                }
                Spacer()
            }
            .safeAreaPadding(.all)
        }
    }
}


#Preview {
    AssignBillView(personViewModel: PersonObjectModel(), billViewModel: BillObjectModel())
}
