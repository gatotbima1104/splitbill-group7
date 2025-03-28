//
//  PeopleListView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI
import UIKit

struct PeopleListView: View {
    
    @ObservedObject var personViewModel: PersonObjectModel
    @State var isAddPersonViewPresented: Bool = false
    // MARK: Delete Person
    @State var personToDelete: PersonModel? // Store the selected person to delete
    
    
    
    var body: some View {
        
        // People list
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                // First item as "Add"
                Button(action: {
                    isAddPersonViewPresented = true
                }) {
                    VStack {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color("Blue"))
                            
                            Text("+")
                                .font(.system(size: 30, weight: .regular))
                                .foregroundColor(.white)
                        }
                            
                        Text("Add Person")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundStyle(Color("ShadedBlue"))
                    }
                }
                
                ForEach(personViewModel.filteredPeople, id: \.id) { item in
                    VStack {
                        ZStack {
                            Circle()
                                .fill(item.color.opacity(0.5))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Circle()
                                        .stroke(
                                            personViewModel.isUserSelected == item.id ? Color.blue : Color.clear,
                                            lineWidth: 3
                                        )
                                )
                            
                            // First letter of the name
                            Text(item.name.prefix(1).uppercased())
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            if !item.bills.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.white)
                                    .background(Circle().fill(Color.blue))
                                    .frame(width: 18, height: 18)
                                    .offset(x: 20, y: 20) // Position the checkmark at the bottom-right corner
                            }
                        }
                        .onLongPressGesture{
                            // add vibration when deleting person
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                            personToDelete = item
                        }
                        
                        Text(item.name.capitalized)
                            .font(.caption)
                            .fontWeight(.regular)
                    }
                    // MARK: Alert to delete person
                    .alert(
                        "Do you want to delete \(personToDelete?.name.capitalized ?? "person")?",
                        isPresented: Binding(
                            get: { personToDelete != nil },
                            set: { if !$0 { personToDelete = nil } } // Reset after dismiss
                        )
                    ) {
                        Button("Delete", role: .destructive) {
                            if let person = personToDelete {
                                personViewModel.removePerson(at: person.id)
                                personToDelete = nil // Clear selection after deleting
                            }
                        }
                        Button("Cancel", role: .cancel) {
                            personToDelete = nil
                        }
                    }
                    .onTapGesture {
                        personViewModel.selecPerson(id: item.id)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .frame(height: 80)
        .padding(.horizontal, 5)
//        .padding(.bottom, 10)
        .sheet(isPresented: $isAddPersonViewPresented){
            AddPersonView(peopleViewModel: personViewModel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    PeopleListView(personViewModel: .init())
}
