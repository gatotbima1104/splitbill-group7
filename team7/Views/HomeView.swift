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
            VStack {
                
                TitleView(text: "Splitbill")
                Spacer()
                
                List {
                    if historyViewModel.historyObjects.isEmpty {
                        ListNotFound(text: "No Bills Yet", size: 150, spacing: 50)
                    } else {
                        ForEach(historyViewModel.historyObjects, id: \.id){ history in
                            NavigationLink (destination: HistoryView(history:history,historyViewModel: historyViewModel).navigationTitle(history.name)
){
                                HStack {
                                    VStack (alignment: .leading, spacing: 10) {
                                        Text(history.name)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        
                                        Text(dateFormatter(history.createdAt))
                                            .font(.caption2)
                                            .fontWeight(.regular)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(history.total, format: .currency(code: "IDR"))
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                                
                            }
                            .listRowInsets(EdgeInsets())
                            .padding()
                            .background(Color(.gray).opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom, 10)
                            .listRowSeparator(.hidden)
                        }
                    }
                }
                .listStyle(PlainListStyle()) // Remove default styling that adds padding
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                
                Spacer()
                
                NavigationLink(destination: AssignBillView(personViewModel: personViewModel, billViewModel: billViewModel,historyViewModel: historyViewModel)) {
                    
                    if historyViewModel.historyObjects.isEmpty {
                        Text("+ New Bills")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("Blue"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }else{
                        Text("Split More Bills")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("Blue"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .safeAreaPadding(.all)
        }
    }
}

#Preview {
    HomeView(historyViewModel: HistoryObjectModel(), billViewModel: BillObjectModel(), personViewModel: PersonObjectModel())
}
