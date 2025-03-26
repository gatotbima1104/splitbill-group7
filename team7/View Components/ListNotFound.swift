//
//  ListNotFound.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI

struct ListNotFound: View {
    
    @State var text: String = "Whoops!"
    @State var size: CGFloat = 100
    @State var spacing: CGFloat = 50
    
    var body: some View {
        VStack(spacing: spacing) {
            Spacer ()
            Text(text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color("Blue"))
                .kerning(-1)
            
            Image(systemName: "text.page.slash.fill")
                .font(.system(size: size))
                .foregroundStyle(Color.blue)
            
            Text("Looks like you have not started anything yet")
                .font(.callout)
                .foregroundStyle(Color.gray)
                .frame(maxWidth: 200)
                .multilineTextAlignment(.center)
            
        }
        .listRowSeparator(.hidden)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ListNotFound()
}
