//
//  ContentView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimated: Bool = false
    @State private var navigateToHome: Bool = false
    @ObservedObject var personViewModel: PersonObjectModel
    @ObservedObject var billViewModel: BillObjectModel
    @ObservedObject var historyViewModel: HistoryObjectModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    Spacer ()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Text("K-BILL")
                        .font(.largeTitle)
                        .foregroundStyle(Color.blue)
                        .fontWeight(.bold)
                    Spacer ()
                }
                .opacity(isAnimated ? 1 : 0)
                .scaleEffect(isAnimated ? 1 : 0.5)
                .animation(.easeInOut(duration: 1), value: isAnimated)
            }
            .safeAreaPadding(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 50)
            .background(Color("TintedBlue"))
            .onAppear {
                isAnimated = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateToHome = true
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView(historyViewModel: historyViewModel, billViewModel: billViewModel, personViewModel: personViewModel)
            }
        }
    }
}


#Preview {
    ContentView(personViewModel: PersonObjectModel(), billViewModel: BillObjectModel(), historyViewModel: HistoryObjectModel())
}
