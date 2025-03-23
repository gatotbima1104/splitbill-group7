//
//  PersonObjectModel.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import Foundation


class PersonObjectModel: ObservableObject {
    @Published var people: [PersonModel] = [
        PersonModel(name: "Gatot"),
        PersonModel(name: "Isa"),
        PersonModel(name: "Ananta"),
        PersonModel(name: "Mario"),
//        PersonModel(name: "Yudha"),
//        PersonModel(name: "Musafa"),
//        PersonModel(name: "Naela"),
//        PersonModel(name: "Gilang"),
//        PersonModel(name: "Jeky"),
    ]
    
    
    @Published var searchText: String = ""
    @Published var isUserSelected: UUID?

        // Computed property to filter people based on searchText
        var filteredPeople: [PersonModel] {
            if searchText.isEmpty {
                return people
            } else {
                return people.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
    
    // select person
    func selecPerson(id: UUID) {
        isUserSelected = id
    }
    
    // Assign a bill to the selected user
    func addUserBill(_ bill: BillModel) {
        guard let selectedId = isUserSelected else {
            print("no user selected.")
            return
        }
        
        if let index = people.firstIndex(where: { $0.id == selectedId }) {
            if !people[index].bills.contains(where: { $0.id == bill.id }) {
                people[index].bills.append(bill)
            }
//            print("\(people[index])")
        }
    }

    // Remove a bill from the selected user
    func removeUserBill(_ userId: UUID, _ bill: BillModel) {
        if let index = people.firstIndex(where: { $0.id == userId }) {
            people[index].bills.removeAll { $0.id == bill.id }
//            print("\(people[index].name) \(assignedBills)")
        }
    }
    
    // add person
    func addPerson(name: String) {
        people.append(PersonModel(name: name))
    }
}
