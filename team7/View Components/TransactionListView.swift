//
//  TransactionListView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var billViewModel: BillObjectModel
    @ObservedObject var personViewModel: PersonObjectModel
    @State private var selectedBills: Set<UUID> = []
    @State private var isAddPersonViewPresented: Bool = false
    @State private var isAddAdditionalFee: Bool = false

    
    // Function to toggle selection state
    private func toggleAndAssignBill(_ bill: BillModel) {
        guard let selectedPerson = selectedPerson else { return }

        if selectedBills.contains(bill.id) {
            // Unassign if already selected
            selectedBills.remove(bill.id)
            personViewModel.removeUserBill(selectedPerson.id, bill)
        } else {
            // Assign to the selected user
            selectedBills.insert(bill.id)
            personViewModel.addUserBill(bill)
        }
    }
    
    
    // Watch for changes in selected user
    var selectedPerson: PersonModel? {
        personViewModel.people.first { $0.id == personViewModel.isUserSelected }
    }
    
    // Function to update checked state when switching users
    private func updateSelectedBills() {
        if let selectedPerson = selectedPerson {
            selectedBills = Set(selectedPerson.bills.map { $0.id }) // Load assigned bills
        } else {
            selectedBills.removeAll() // Reset if no user is selected
        }
    }
    
    // Function to toggle selection state
    private func toggleBillSelection(_ bill: BillModel) {
        guard let selectedPerson = selectedPerson else { return }
        
        if selectedBills.contains(bill.id) {
            selectedBills.remove(bill.id) // Uncheck
            personViewModel.removeUserBill(selectedPerson.id, bill) // Remove from user's assigned bills
        } else {
            selectedBills.insert(bill.id) // Check
            personViewModel.addUserBill(bill) // Assign to user
        }
    }
    
    var body: some View {
        
        VStack {

            // Custom fontWeight
            HStack {
                Text("Item Details")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                
                Button(action: {
                    isAddPersonViewPresented = true
                }){
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(Color("ShadedBlue"))
//                        .padding(.all, 5)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(5)
                }
                    
                
            }
            
            // Search bar
            SearctBarView(search: $billViewModel.searchText, placeholder: "Seacrh Bill here")

            List {
                if billViewModel.bills.isEmpty {
                    ListNotFound(text: "No Items Yet", size: 100, spacing: 10)
                }else{
                    ForEach(billViewModel.filteredBills, id: \.id) { bill in
                        HStack {
                            
                            Image(systemName: !selectedBills.contains(bill.id) ? "circle" : "checkmark.circle.fill")
                                .foregroundColor(!selectedBills.contains(bill.id) ? Color.gray : Color("Blue"))
                                .fontWeight(.regular)
                                .font(.title2)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(bill.name)
                                        .font(.callout)
                                        .fontWeight(.medium)
                                    Text(bill.price, format: .currency(code: "IDR"))
                                        .font(.footnote)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color(.systemGray))
                                    Text("x \(personViewModel.people.filter { $0.bills.contains(where: { $0.id == bill.id }) }.count)")
                                        .font(.footnote)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color(.systemGray))
                                }
                                .padding(.horizontal, 5)
                                
                                Spacer()
                                
                                VStack {
                                    VStack(alignment: .trailing, spacing: 5) {
                                        let people = personViewModel.people
                                            .filter { $0.bills.contains(where: { $0.id == bill.id }) }
                                            .map { $0.name }

                                        LazyVGrid(
                                            columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: min(people.count, 3)),
                                            spacing: 5
                                        ) {
                                            ForEach(people.reversed(), id: \.self) { person in
                                                HStack {
                                                    Spacer()
                                                    Text(person.prefix(1))
                                                        .frame(minWidth: 30)
                                                        .lineLimit(1)
                                                        .truncationMode(.tail)
                                                        .padding(.vertical, 5)
                                                        .padding(.horizontal, 8)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color.blue, lineWidth: 2)
                                                        )
                                                        .cornerRadius(8)
                                                        .font(.caption2)
                                                        .foregroundColor(.blue)
                                                }
                                            }
                                        }
                                        .frame(maxWidth: 150, alignment: .trailing)
                                    }
                                }
                            }
                            
                            Spacer()
            //

                            
                        }.onTapGesture {
                            toggleAndAssignBill(bill)
                        }
                        .padding(.vertical)
            //            .padding(.horizontal)
            //            .background(Color.gray.opacity(0.1))
                        .listRowInsets(EdgeInsets())
                        
                    }
                    
                }
            }
                        .listStyle(PlainListStyle())
                        .padding(.horizontal, 0)

        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
        .sheet(isPresented: $isAddPersonViewPresented){
            AddBillView(billViewModel: billViewModel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isAddAdditionalFee){
            AddAdditionaFeeView(billViewModel: billViewModel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .onChange(of: personViewModel.isUserSelected) {
            updateSelectedBills() // Reset selection when switching users
        }
        
        // Additional fee container
        HStack {
            Image(systemName: "plus")
            Text("Add Additional Fee")
                .font(.footnote)
                .fontWeight(.regular)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue, lineWidth: 2)
        )
        .foregroundColor(.blue)
        .foregroundColor(Color("ShadedBlue"))
        .cornerRadius(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            isAddAdditionalFee = true
        }
    }
}


#Preview {
    TransactionListView(billViewModel: .init(), personViewModel: .init())
}
