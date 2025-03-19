//
//  HistoryView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Transaction Details")
            
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
            }
        }
        .safeAreaPadding(.all)
    }
}

#Preview {
    HistoryView()
}
