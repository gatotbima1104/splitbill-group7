//
//  TitleGenerator.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 21/03/25.
//
import Foundation

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HHmmss"
    return formatter
}()

func generateTitle(name: String) -> String {
    let timeString = timeFormatter.string(from: Date())
    return "\(name)#\(timeString)"
}
