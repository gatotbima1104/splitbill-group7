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
    
    var body: some View {
        
        // People list
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                // First item as "Add"
                Button(action: {
                    isAddPersonViewPresented = true
                }) {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.gray)
                            
                        Text("Add")
                            .font(.caption)
                            .fontWeight(.regular)
                    }
                }
                
                ForEach(personViewModel.filteredPeople, id: \.id) { item in
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                            .padding(3)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.green, lineWidth: 3)
                            )
                            .foregroundColor(item.color)
                        Text(item.name)
                            .font(.caption)
                            .fontWeight(.regular)
                    }.padding(.vertical)
                }
            }
        }
        .frame(height: 120)
        .padding(.horizontal, 5)
        .padding(.bottom, 28)
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
