//
//  TitleView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct TitleView: View {
    
    var text: String = ""
    
    var body: some View {
        Text(text)
            .font(.title)
        Divider()
            .frame(height: 1)
            .background(Color.black)
            .padding(.bottom)
    }
}
