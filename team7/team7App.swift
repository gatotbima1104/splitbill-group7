//
//  team7App.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

@main
struct team7App: App {
    // open the content splash only when user open app
    @State private var showContentView = true
    
    var body: some Scene {
        WindowGroup {
            if showContentView {
                ContentView(
                    personViewModel: PersonObjectModel(),
                    billViewModel: BillObjectModel(),
                    historyViewModel: HistoryObjectModel()
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showContentView = false
                    }
                }
            } else {
                HomeView(
                    historyViewModel: HistoryObjectModel(),
                    billViewModel: BillObjectModel(),
                    personViewModel: PersonObjectModel()
                )
            }
        }
    }
}
