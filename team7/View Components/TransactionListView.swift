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
            selectedBills.remove(bill.id) // Uncheck
            personViewModel.removeUserBill(selectedPerson.id, bill)
        } else {
            // Assign to the selected user
            selectedBills.insert(bill.id) // Check
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
    
    var body: some View {
        
        VStack {

            // Custom fontWeight
            HStack {
                Text("Item's Details")
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
                }
            }
            
            // Search bar
            if !billViewModel.bills.isEmpty {
                SearctBarView(search: $billViewModel.searchText, placeholder: "Seacrh Bill here")
            }
            
            List {
                if billViewModel.bills.isEmpty {
//                    ListNotFound(text: "No Items Yet", size: 50, spacing: 10)
                    ListNotFound(size: 36, spacing: 30)
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
//                                    Text("x\(personViewModel.people.filter { $0.bills.contains(where: { $0.id == bill.id }) }.count)")
//                                        .font(.footnote)
//                                        .fontWeight(.regular)
//                                        .foregroundColor(Color(.systemGray))
                                }
                                .padding(.horizontal, 5)
                                
                                Spacer()
                                
                                VStack {
                                    VStack(alignment: .trailing, spacing: 5) {
                                        let people = personViewModel.people
                                            .filter { $0.bills.contains(where: { $0.id == bill.id }) }

                                        HStack(spacing: -10) {
                                            ForEach(people, id: \.id) { person in
                                                ZStack {
                                                    Circle()
                                                        .fill(person.color.opacity(0.7))
                                                        .frame(width: 30, height: 30)
                                                        .overlay(
                                                            Circle()
                                                                .stroke(Color.white, lineWidth: 2)
                                                        )
                                                    
                                                    Text(person.name.prefix(1).uppercased())
                                                        .font(.footnote)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                                        .frame(maxWidth: 150, alignment: .trailing)
                                    }
                                }
                            }
                            
                            Spacer()
                            
                        }.onTapGesture {
                            toggleAndAssignBill(bill)
                        }
                        .padding(.vertical)
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: billViewModel.removeBill)
                }
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 0)

        }
//        .border(Color.blue)
        .padding(.vertical, 24)
        .padding(.horizontal, 8)
        .background(Color.white)
        .cornerRadius(8)
        
//        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
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
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 20)) // Increase size
                .imageScale(.large)
            
            Text(billViewModel.taxPercentage > 0 &&  billViewModel.additionalFee > 0  ? "Tax: \(String(format: "%.2f", billViewModel.taxPercentage))%, Additional Fee: \(formatToRupiah(billViewModel.additionalFee))" : billViewModel.taxPercentage > 0 ? "Tax: \(String(format: "%.2f", billViewModel.taxPercentage))%" : billViewModel.additionalFee > 0 ? "Additional Fee: \(formatToRupiah(billViewModel.additionalFee))" : "Any other additional fee?")
                .font(.callout)
                .foregroundStyle(Color("ShadedBlue"))
                .fontWeight(.regular)
            
            Spacer ()
            
            if billViewModel.taxPercentage > 0 ||  billViewModel.additionalFee > 0 {
                Image(systemName: "x.circle.fill")
                    .foregroundStyle(.gray)
                    .onTapGesture {
                    billViewModel.taxPercentage = 0
                    billViewModel.additionalFee = 0
                }
            } else{
                Image(systemName: "plus") .foregroundStyle(Color("ShadedBlue"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(Color.blue.opacity(0.1))
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.blue, lineWidth: 2)
//        )
        .foregroundColor(.blue)
        .foregroundColor(Color("ShadedBlue"))
        .cornerRadius(8)
        .onTapGesture {
            isAddAdditionalFee = true
        }
        .padding(.top)
    }

}


#Preview {
    TransactionListView(billViewModel: .init(), personViewModel: .init())
}
