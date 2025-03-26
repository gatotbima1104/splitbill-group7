//
//  PersonObjectModel.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import Foundation


class PersonObjectModel: ObservableObject {
    
    
    @Published var people: [PersonModel] = [] {
        didSet {
            savePeople() // Save whenever data changes
            updateFilteredPeople() // Ensure filteredPeople updates
        }
    }
    
    private let peopleKey = "peopleData"

    init() {
        loadPeople() // Load saved history when the app starts
        updateFilteredPeople() // Initialize filteredPeople
    }
    
    /// **Saves historyObjects to UserDefaults**
    private func savePeople() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let encodedData = try? encoder.encode(people) {
            UserDefaults.standard.set(encodedData, forKey: peopleKey)
        }
    }
    
    /// **Loads historyObjects from UserDefaults**
    private func loadPeople() {
        if let savedData = UserDefaults.standard.data(forKey: peopleKey) {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedHistory = try? decoder.decode([PersonModel].self, from: savedData) {
                self.people = decodedHistory
                return
            }
        }
    }
    
    
    
    
    @Published var searchText: String = "" {
            didSet {
                updateFilteredPeople() // Update filteredPeople whenever search text changes
            }
        }
    
    @Published var filteredPeople: [PersonModel] = [] // Now observable
    @Published var isUserSelected: UUID?

    
    
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
    
    // remove person
    func removePerson(at id: UUID) {
        if let index = people.firstIndex(where: {$0.id == id}) {
            people.remove(at: index)
        }
    }
    
    
    func clearAllPersonBills() {
        for index in people.indices {
            people[index].bills.removeAll()
        }
    }
    
    // Updates filteredPeople whenever searchText or people changes
       private func updateFilteredPeople() {
           if searchText.isEmpty {
               filteredPeople = people
           } else {
               filteredPeople = people.filter { $0.name.lowercased().contains(searchText.lowercased()) }
           }
       }
}
