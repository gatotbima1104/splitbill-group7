//
//  DateFormatter+Extensions.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//


import Foundation
import UIKit
import SwiftUI

public func dateFormatter(_ date: Date) -> String {
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd MMMM yyyy"
    return outputFormatter.string(from: date)
}
