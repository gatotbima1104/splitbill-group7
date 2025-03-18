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
            HStack(spacing: 10) {
                // First item as "Add"
                Button(action: {
                    isAddPersonViewPresented = true
                }) {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(.gray)
                        Text("Add")
                            .font(.caption)
                    }
                }
                
                ForEach(personViewModel.filteredPeople, id: \.id) { item in
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundColor(item.color)
                        Text(item.name)
                            .font(.caption)
                    }
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
//    PeopleListView(personViewModel: .init())
}
