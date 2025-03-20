//
//  HistoryView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI

struct HistoryView: View {
    var history : HistoryModel
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading){
                    Text("Payment").font(.title3)
                        .fontWeight(.semibold)
                    
                    ForEach(Array(history.people.enumerated()), id: \.offset) { index, element in
                        let userPaid = history.people[index].bills.reduce(0) { $0 + $1.price }
                        HStack{
                            history.people[index].isPaid ?
                            Image(systemName: "checkmark.square.fill")
                            :Image(systemName: "square")
                            Text(history.people[index].name)
                                .font(.callout)
                            Spacer()
                            Text(userPaid, format: .currency(code: "IDR"))
                                .font(.callout)
                                .fontWeight(.regular)
                            
                        }.padding(.top,5).onTapGesture {
//                            history.people[index].isPaid.toggle()
                        }
                      
                    }
                    
                  
                }
                .safeAreaPadding(.all)
                .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                
           
                
                
                VStack(alignment: .leading){
                    Text("Item Details").font(.title3)
                        .fontWeight(.semibold)
                    ForEach(history.bills){bill in
                        let filteredPeople : [PersonModel] = history.people
                            .filter { $0.bills.contains(where: { $0.name == bill.name }) }
                            .map { $0 }

                        VStack(alignment: .leading) {
                            HStack{
                                Text(bill.name)
                                    .font(.callout)
                                Spacer()
                                Text(bill.price, format: .currency(code: "IDR"))
                                    .font(.callout)
                                    .fontWeight(.regular)
                                .foregroundColor(Color(.systemGray))                }
                            HStack(){
                                ForEach(Array(filteredPeople.enumerated()), id: \.offset) { index, element in
                                    Text(element.name).font(.caption)
                                        .padding(.vertical, 3)
                                        .padding(.horizontal, 5)
                                        .foregroundStyle(.white)
                                        .background(element.color)
                                        .cornerRadius(5)
                                }
                                
                            }
                          
                        }.padding(.top,5)
                    }
                    
                    Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(height: 1).padding(.top)
                    
                    HStack{
                        Text("Total")
                            .font(.callout)
                        Spacer()
                        Text(history.total, format: .currency(code: "IDR"))
                            .font(.callout)
                            .fontWeight(.regular)
                        .foregroundColor(Color(.systemGray))
                    }.padding(.top,5)
                }
                .safeAreaPadding(.all)
                .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                
           
                
                
                   
            }
            .safeAreaPadding(.all)
        }
        
        Spacer ()

        Button(action: {
        }){
            HStack {
                Image(systemName: "square.and.arrow.up.fill")
                Text("Share")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.green))
            .foregroundColor(.white)
            .cornerRadius(10)
            .safeAreaPadding(.all)
    }
      
    }
}

#Preview {
    HistoryView(history: HistoryModel(name: "Nama Bill", total: 120000, people: [PersonModel(name: "Mushafa")], bills: [BillModel(name: "Teh Obeng", price: 3000)]))
}
