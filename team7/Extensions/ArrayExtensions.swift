//
//  ArrayExtensions.swift
//  team7
//
//  Created by Mushafa Fadzan Andira on 20/03/25.
//

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}
