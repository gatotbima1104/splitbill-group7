//
//  HistoryView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI
import UIKit

struct HistoryView: View {
    var history : HistoryModel
    @ObservedObject var historyViewModel: HistoryObjectModel
    @State private var screenshotImage: UIImage?
    @State private var expandTracker : Bool = true
    var body: some View {
        ScrollView{
            VStack(spacing: 5) {
                Divider()
                Text("Split Bill Summary").font(.title3).fontWeight(.semibold).padding(.top)
                PaybackTrackerView(history: history, historyViewModel: historyViewModel,expandTracker: $expandTracker)
                
                PaymentInformationView(history: history, historyViewModel: historyViewModel)
                
               
                
           
                
                
           
                
                
                   
            }
        }
        
        Spacer ()

        Button(action: shareHistory) {
            HStack {
                Image(systemName: "square.and.arrow.up.fill")
                Text("Share")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("Blue"))
            .foregroundColor(.white)
            .cornerRadius(20)
            .safeAreaPadding(.all)
        }
    }
    
    // Share result to image 
    func shareHistory() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let renderer = UIGraphicsImageRenderer(size: window.bounds.size)
        let image = renderer.image { ctx in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }

        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        if let rootViewController = window.rootViewController {
            rootViewController.present(activityController, animated: true, completion: nil)
        }
    }

}


struct PaybackTrackerView : View {
    var history : HistoryModel
    @ObservedObject var historyViewModel: HistoryObjectModel
    @Binding var expandTracker: Bool
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("Payback Tracker").font(.headline).foregroundStyle(.white)
                Spacer()
                Image(systemName:
                        expandTracker ? "chevron.up.square" : "chevron.down.square").foregroundStyle(.white)
            }
            .padding(.all,10)
            .background(Color("Blue"))
            .onTapGesture {
                expandTracker.toggle()
            }
            
            if expandTracker {
                ForEach(Array(history.people.enumerated()), id: \.offset) { index, element in
                    let userPaid : Double = history.people[index].bills.reduce(0) {
                        
                        $0 + ($1.price *  (1 + (history.taxPercentage / 100)))}
                    let additionalFee : Double = (history.additionalFee / Double(history.people.count))
                    let totalPaid : Double = userPaid + additionalFee
                    
                    
                    VStack {
                        HStack(alignment:.top) {
                            if history.people[index].isPaid {
                                Image(systemName: "checkmark.circle.fill").foregroundStyle(Color("Blue"))
                            } else{
                                Image(systemName: "checkmark.circle.fill").foregroundStyle(.gray)
                            }
                            VStack{
                                if history.people[index].isPaid {
                                    HStack{
                                        Text(history.people[index].name)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.gray)
                                            .strikethrough()
                                        Spacer()
                                        Text(totalPaid, format: .currency(code: "IDR"))
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.gray)
                                            .strikethrough()


                                        
                                    }
                                } else{
                                    HStack{
                                        Text(history.people[index].name)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color("Blue"))

                                        Spacer()
                                        Text(totalPaid, format: .currency(code: "IDR"))
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color("Blue"))

                                        
                                    }
                                }
                                ForEach(history.people[index].bills, id: \.id) { bill in
                                    if history.people[index].isPaid{
                                        HStack{
                                            Text(bill.name)
                                                .font(.caption).foregroundStyle(.gray).strikethrough()
                                            Spacer()
                                            Text(bill.price * (1 + (history.taxPercentage / 100)), format: .currency(code: "IDR"))
                                                .font(.caption)
                                                .foregroundStyle(.gray).strikethrough()
                                            
                                        }.padding(.top,3)
                                    } else{
                                        HStack{
                                            Text(bill.name)
                                                .font(.caption)
                                            Spacer()
                                            Text(bill.price * (1 + (history.taxPercentage / 100)), format: .currency(code: "IDR"))
                                                .font(.caption)
                                        }.padding(.top,3)
                                    }
                                   
                                }
                                if history.additionalFee > 0 {
                                    if history.people[index].isPaid{
                                        HStack{
                                            Text("Additional Fee")
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                                .strikethrough()
                                            Spacer()
                                            Text((history.additionalFee / Double(history.people.count)), format: .currency(code: "IDR"))
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                                .strikethrough()
                                        }.padding(.top,3)
                                    } else{
                                        HStack{
                                            Text("Additional Fee")
                                                .font(.caption)
                                            Spacer()
                                            Text((history.additionalFee / Double(history.people.count)), format: .currency(code: "IDR"))
                                                .font(.caption)
                                        }.padding(.top,3)
                                    }
                                   
                                    
                                }
                            }
                            
                        }
                        
                        Line()
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .frame(height: 1).padding(.top)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        historyViewModel.toggleIsPaid(personId: history.people[index].id, historyId: history.id)
                    }
                    .padding(.top,10)
                    
                    
                   
                    
                   
                   
                  
                }
            }
            
           
        }.padding(.all)
    }
}


struct PaymentInformationView : View {
    var history : HistoryModel
    @ObservedObject var historyViewModel: HistoryObjectModel
    @State private var paymentAccount : String = ""
    @State private var paymentNumber : String = ""
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("Payback Information").font(.headline).foregroundStyle(.white)
                Spacer()
                
            }
            .padding(.all,10)
            .background(Color("Blue"))
            
            Section {
              
                    HStack {
                        Text("Account")
                        Divider()
                        Spacer()

                        TextField("Account", text: Binding(
                            get: { history.paymentMethod ?? "" },
                            set: { newValue in
                                if let index = historyViewModel.historyObjects.firstIndex(where: { $0.id == history.id }) {
                                    historyViewModel.historyObjects[index].paymentMethod = newValue
                                }
                            }
                        ))
                        
                    }
                    HStack {
                        Text("Number")
                        Divider()
                        Spacer()

                        TextField("Account Number", text: Binding(
                            get: { history.paymentNumber ?? "" },
                            set: { newValue in
                                if let index = historyViewModel.historyObjects.firstIndex(where: { $0.id == history.id }) {
                                    historyViewModel.historyObjects[index].paymentNumber = newValue
                                }
                            }
                        ))
                        
                    }
            }
            .padding(.vertical, 10)
        
            
            
           
        }.padding(.all)
    }
}


#Preview {
    HistoryView(history: HistoryModel(name: "Nama Bill", people: [PersonModel(name: "Mushafa")], bills: [BillModel(name: "Teh Obeng", price: 3000)]), historyViewModel: .init())
}
