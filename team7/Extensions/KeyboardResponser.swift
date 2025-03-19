//
//  KeyboardResponser.swift
//  team7
//
//  Created by Muhamad Gatot Supiadin on 19/03/25.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var isKeyboardVisible = false
    private var cancellable: AnyCancellable?

    init() {
        self.cancellable = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .sink { [weak self] notification in
                self?.isKeyboardVisible = (notification.name == UIResponder.keyboardWillShowNotification)
            }
    }
}
