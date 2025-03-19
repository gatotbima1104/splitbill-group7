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
                Section {
                    TextField("Name", text: $newPerson)
                } header: {
                    Text("Enter The Name")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss() // Dismiss the sheet
                    }
                }
                ToolbarItem(placement: .principal) { 
                    Text("Add People")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        peopleViewModel.addPerson(name: newPerson)
                        dismiss()
                    }
                    .disabled(newPerson.isEmpty)
                    .foregroundStyle(newPerson.isEmpty ? Color.gray : Color.blue)
                }
            }
        }
    }
}

