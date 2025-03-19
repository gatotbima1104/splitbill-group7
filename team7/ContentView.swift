//
//  ContentView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: HomeView(historyViewModel: HistoryObjectModel(), billViewModel: BillObjectModel(), personViewModel: PersonObjectModel())) {
                Text ("Hello World")
            }
        }
    }
}


#Preview {
    ContentView()
}
