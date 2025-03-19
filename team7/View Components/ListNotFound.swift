//
//  ListNotFound.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI

struct ListNotFound: View {
    
    @State var text: String = ""
    @State var size: CGFloat = 0
    @State var spacing: CGFloat = 0
    
    var body: some View {
        VStack(spacing: spacing) {
            Spacer ()
            Text(text)
                .font(.title3)
                .fontWeight(.regular)
            
            Image(systemName: "x.circle.fill")
                .font(.system(size: size))
                .foregroundStyle(Color.red.opacity(0.3))
            
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
