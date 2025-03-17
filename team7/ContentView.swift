//
//  ContentView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var search: String = ""
    @State private var people: [String] = ["Gatot", "Musafa", "Ananta", "Gilang", "Zaky"]
    
    var body: some View {
        VStack {
            Text("Bills Title")
                .font(.title)
            Divider()
                .padding(.bottom)
                
            // Search bar
            SearctBarView(search: $search)
    
            // People list
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(people, id: \.self) { item in
                        VStack {
                            Image("download")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text(item)
                                .font(.headline)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 150)
            
            Spacer()
            
        }
        .safeAreaPadding(.all)
        .padding()
    }
}


#Preview {
    ContentView()
}
