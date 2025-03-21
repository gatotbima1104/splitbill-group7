//
//  HistoryView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI

struct HistoryView: View {
    var history : HistoryModel
    @State private var pickedPayment = 0
    @State private var paymentAccount : String = ""
    @State private var paymentNumber : String = ""
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    Text("Payment").font(.title3)
                        .fontWeight(.semibold)
                    Section {
                        Picker("What is your payment method?", selection: $pickedPayment) {
                                Text("Cash").tag(0)
                                Text("Transfer").tag(1)
                            }
                            .pickerStyle(.segmented)
                        
                        if pickedPayment == 1 {
                            HStack {
                                Text("Account")
                                Divider()
                                Spacer()

                                TextField("Account", text: $paymentAccount).multilineTextAlignment(.trailing)
                                
                            }
                            HStack {
                                Text("Number")
                                Divider()
                                Spacer()

                                TextField("Account Number", text: $paymentNumber).multilineTextAlignment(.trailing)
                                
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    
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
                    ForEach(history.bills.filter{ bill in
                        let xQuantity = history.people.filter { $0.bills.contains(where: { $0.name == bill.name }) }.count
                            return xQuantity > 0
                            }){bill in
                                let filteredPeople : [PersonModel] = history.people
                                    .filter { $0.bills.contains(where: { $0.name == bill.name }) }
                                    .map { $0 }

                                VStack(alignment: .leading) {
                                    HStack{
                                        Text(bill.name)
                                            .font(.callout)
                                        Divider ()
                                        Text("x\(filteredPeople.count)")
                                            .font(.footnote)
                                        Spacer()
                                        Text(bill.price * Double(filteredPeople.count), format: .currency(code: "IDR"))
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
    HistoryView(history: HistoryModel(name: "Nama Bill", people: [PersonModel(name: "Mushafa")], bills: [BillModel(name: "Teh Obeng", price: 3000)]))
}
