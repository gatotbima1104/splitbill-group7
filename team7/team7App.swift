//
//  team7App.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

@main
struct team7App: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ContentView(personViewModel: PersonObjectModel(), billViewModel: BillObjectModel(), historyViewModel: HistoryObjectModel())
        }
    }
}
