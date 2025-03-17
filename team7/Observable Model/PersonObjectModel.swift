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
    
    func addPerson(name: String) {
        people.append(PersonModel(name: name))
    }
}
