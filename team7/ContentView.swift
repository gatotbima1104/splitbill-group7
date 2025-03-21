//
//  ContentView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAnimated: Bool = false
    @ObservedObject var personViewModel: PersonObjectModel
    @ObservedObject var billViewModel: BillObjectModel
    @ObservedObject var historyViewModel: HistoryObjectModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    Spacer ()
                    Text("Split Your Bill's Money")
                        .foregroundStyle(.black)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(isAnimated ? 1 : 0)
                        .offset(x: isAnimated ? 0 : 20)
                        .animation(.easeInOut(duration: 1), value: isAnimated)
                    
                    Text("Not Your time")
                        .foregroundStyle(.black)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .opacity(isAnimated ? 1 : 0)
                        .offset(x: isAnimated ? 0 : 20)
                        .animation(.easeInOut(duration: 1), value: isAnimated)
                    Spacer ()
                }
                
                NavigationLink(destination: HomeView(historyViewModel: historyViewModel, billViewModel: billViewModel, personViewModel: personViewModel)) {
                    Button(action: {
                    }) {
                        Text("Next")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                    .allowsHitTesting(false)
                    .padding(.top, 30)
                    .opacity(isAnimated ? 1 : 0)
                    .offset(y: isAnimated ? 0 : 20)
                    .animation(.easeInOut(duration: 1).delay(0.4), value: isAnimated)
                }
            }
            .safeAreaPadding(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 50)
            .background(Color("TintedBlue"))
            .onAppear{
                isAnimated = true
            }
        }
    }
}


#Preview {
    ContentView(personViewModel: PersonObjectModel(), billViewModel: BillObjectModel(), historyViewModel: HistoryObjectModel())
}
