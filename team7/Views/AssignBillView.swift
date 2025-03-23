//
//  AssignBillView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct AssignBillView: View {
    @State private var shouldNavigate = false
    @ObservedObject var personViewModel: PersonObjectModel
    @ObservedObject var billViewModel: BillObjectModel
    @ObservedObject var historyViewModel: HistoryObjectModel
    @State var billsName: String = ""
    
    @State var addedHistory : HistoryModel? = nil
    
    // check if at least one person has bills to enable next btn
    var isNextButtonDisabled: Bool {
        return personViewModel.filteredPeople.allSatisfy { $0.bills.isEmpty }
    }


    var body: some View {
        NavigationStack {
            VStack {
                
                // People
                // Title named
                HStack{
                    TextField("Bill Title", text: $billsName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(width: 150)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled(true)
                        .multilineTextAlignment(.center)
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Divider()
                    .fontWeight(.semibold)
                    .background(Color.black)
                    .padding(.bottom)
                
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
                
                Button(action: {
                    // Example: Validate input, save data, update state
                    if billsName.isEmpty {
                        billsName = generateTitle(name: "SplitBill")
                    }
                    addedHistory = HistoryModel(
                        name: billsName,
                        people: personViewModel.filteredPeople.filter { !$0.bills.isEmpty },
                        bills: billViewModel.bills
                    )

                    // add to history list
                    historyViewModel.historyObjects.append(addedHistory!)
                    // Navigate after action
                
                    shouldNavigate = true
                }){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(!isNextButtonDisabled ? Color("Blue") : Color("Blue").opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.disabled(isNextButtonDisabled)
                    .navigationDestination(isPresented: $shouldNavigate) {
                                       HistoryView(
                                        history: addedHistory ?? HistoryModel(
                                            name: billsName,
                                            people: personViewModel.filteredPeople.filter { !$0.bills.isEmpty },
                                            bills: billViewModel.bills
                                        ),
                                           historyViewModel: historyViewModel
                                       )
                                       .navigationTitle(billsName)
                                   }

                NavigationLink(destination: HistoryView(history: HistoryModel(name: billsName.isEmpty ? generateTitle(name: "SplitBill") : billsName, people: personViewModel.filteredPeople.filter{ !$0.bills.isEmpty }, bills: billViewModel.bills),historyViewModel: historyViewModel).navigationTitle(billsName.isEmpty ? generateTitle(name: "SplitBill") : billsName)) {
                   
                }
                Spacer()
            }
            .safeAreaPadding(.all)
        }
    }
}


#Preview {
    AssignBillView(personViewModel: PersonObjectModel(), billViewModel: BillObjectModel(),historyViewModel: .init())
}
