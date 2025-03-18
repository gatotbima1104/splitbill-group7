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
            NavigationLink(destination: AssignBillView(personViewModel: PersonObjectModel(), billViewModel: BillObjectModel())) {
                Text ("Hello World")
            }
        }
    }
}


#Preview {
    ContentView()
}
