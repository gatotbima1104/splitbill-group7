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
        PersonModel(name: "Yudha"),
        PersonModel(name: "Musafa"),
        PersonModel(name: "Naela"),
        PersonModel(name: "Gilang"),
        PersonModel(name: "Jeky"),
    ]
    
    
    @Published var searchText: String = ""

        // Computed property to filter people based on searchText
        var filteredPeople: [PersonModel] {
            if searchText.isEmpty {
                return people
            } else {
                return people.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
    
    
    func addPerson(name: String) {
        people.append(PersonModel(name: name))
    }
}
