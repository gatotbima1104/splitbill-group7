//
//  TitleGenerator.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 21/03/25.
//
import Foundation

// generate title by numbers increment
func generateTitle(name: String) -> String {
    let key = "splitBillCounter"
    let currentCount = UserDefaults.standard.integer(forKey: key) + 1
    UserDefaults.standard.set(currentCount, forKey: key)
    
    return "\(name)#\(currentCount)"
}
