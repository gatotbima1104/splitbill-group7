//
//  HomeView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI

struct HomeView: View {
    
    
    @ObservedObject var historyViewModel: HistoryObjectModel
    @ObservedObject var billViewModel: BillObjectModel
    @ObservedObject var personViewModel: PersonObjectModel
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Image("Bgg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    if historyViewModel.historyObjects.isEmpty {
                        ListNotFound(size: 48, spacing: 30)
                    } else {
                        VStack {
                            Image("Logo")
                                .resizable()
                                .frame(width: 80, height: 80, alignment: .center)
                                .padding()
                                .background(Color.clear)
                            Text("History")
                                .font(.title2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(.top, -24)
                                .foregroundStyle(Color("ShadedBlue"))
                                .fontWeight(.bold)
                        }
                        .padding(.top, -20)
                        
                        ForEach(historyViewModel.historyObjects.prefix(4), id: \.id){ history in
                            NavigationLink (destination: HistoryView(history:history,historyViewModel: historyViewModel).navigationTitle(history.name)
                            ){
                                HStack {
                                    VStack (alignment: .leading, spacing: 10) {
                                        Text(history.name)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color("ShadedBlue"))
                                        
                                        Text(dateFormatter(history.createdAt))
                                            .font(.caption2)
                                            .fontWeight(.regular)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        // Show people
                                        HStack(spacing: -10) { // overlap effect
                                            ForEach(history.people, id: \.id) { person in
                                                ZStack {
                                                    Circle()
                                                        .fill(person.color.opacity(0.7))
                                                        .frame(width: 40, height: 40)
                                                        .overlay(
                                                            Circle()
                                                                .stroke(Color.white, lineWidth: 2)
                                                        )
                                                    
                                                    // Letter first name
                                                    Text(person.name.prefix(1).uppercased())
                                                        .font(.headline)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                                        
                                        Text("\(history.calculateTotal(), format: .currency(code: "IDR")),-")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            
                        }
                        .onDelete(perform: historyViewModel.removeHistory)
                    }
                }
                .padding(.top, 120)
                .padding(.vertical, historyViewModel.historyObjects.isEmpty ? 50 : 16)
                .listStyle(PlainListStyle())
                .background(.clear)
                .scrollContentBackground(.hidden)
                
                // Navigation button
                NavigationLink(destination: AssignBillView(
                    personViewModel: personViewModel,
                    billViewModel: billViewModel,
                    historyViewModel: historyViewModel
                )
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Bill Detail")
                            .font(.title2)
                            .fontWeight(.bold)
                            .baselineOffset(-50)
                    }
                }) {
                    Text(historyViewModel.historyObjects.isEmpty ? "Start Split Your Bill" : "+ Split More Bills")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Blue"))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, historyViewModel.historyObjects.isEmpty ? 86 : 26)
                .padding(.bottom, historyViewModel.historyObjects.isEmpty ? 102 : 20)
                .padding(.top, historyViewModel.historyObjects.isEmpty ? 400 : 700)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    HomeView(historyViewModel: HistoryObjectModel(), billViewModel: BillObjectModel(), personViewModel: PersonObjectModel())
}
