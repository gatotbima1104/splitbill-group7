//
//  PeopleListView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct PeopleListView: View {
    
    @ObservedObject var personViewModel: PersonObjectModel
    @State var isAddPersonViewPresented: Bool = false
    
    // Generate a random color based on the user's ID
    func randomColor(for id: UUID) -> Color {
        let colors: [Color] = [.red, .green, .orange, .purple, .pink, .yellow]
        return colors[id.hashValue % colors.count] // Assign a consistent color
    }
    
    var body: some View {
        
        // People list
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                // First item as "Add"
                Button(action: {
                    isAddPersonViewPresented = true
                }) {
                    VStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(3)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(Color("ShadedBlue"))
                            
                        Text("Add")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundStyle(Color("ShadedBlue"))
                    }
                }
                
                ForEach(personViewModel.filteredPeople, id: \.id) { item in
                    VStack {
                        ZStack {
                            Circle()
                                .fill(item.color.opacity(0.7))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Circle()
                                        .stroke(
                                            personViewModel.isUserSelected == item.id ? Color.blue : Color.clear,
                                            lineWidth: 5
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
                                    .background(Circle().fill(Color.green))
                                    .frame(width: 18, height: 18)
                                    .offset(x: 20, y: 20) // Position the checkmark at the bottom-right corner
                            }
                        }
                        
                        Text(item.name.capitalized)
                            .font(.caption)
                            .fontWeight(.regular)
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
        .padding(.bottom, 10)
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
