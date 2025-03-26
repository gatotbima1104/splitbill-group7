//
//  TitleGenerator.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 21/03/25.
//
import Foundation

// Generate by numbers increment
func generateTitle(name: String) -> String {
    struct Counter {
        static var count = 0
    }
    
    Counter.count += 1
    return "\(name)#\(Counter.count)"
}
