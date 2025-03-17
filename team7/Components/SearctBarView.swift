//
//  SearctBarView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct SearctBarView: View {
    
    @Binding var search: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search People here ", text: $search)
                .autocorrectionDisabled()
                .autocapitalization(.none)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
