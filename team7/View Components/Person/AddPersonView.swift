//
//  AddPe.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 18/03/25.
//


import SwiftUI

struct AddPersonView: View {
    
    @State var newPerson: String = ""
    @ObservedObject var peopleViewModel: PersonObjectModel
    @Environment(\.dismiss) var dismiss // Used to close the sheet
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $newPerson)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss() // Dismiss the sheet
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        peopleViewModel.addPerson(name: newPerson)
                        dismiss()
                    }
                    .disabled(newPerson.isEmpty)
                }
            }
        }
    }
}

