//
//  ButtonView.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 17/03/25.
//

import SwiftUI

struct ButtonView: View {
    
    var text: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(text)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        
    }
}
