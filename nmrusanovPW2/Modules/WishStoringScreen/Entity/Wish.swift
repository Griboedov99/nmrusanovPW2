//
//  Wish.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

// MARK: - Wish container
struct Wish: Codable {
    let id: UUID
    var text: String
    let createdAt: Date
    
    init(text: String) {
        self.id = UUID()
        self.text = text
        self.createdAt = Date()
    }
}

// MARK: - Equatable for comparison
extension Wish: Equatable {
    static func == (lhs: Wish, rhs: Wish) -> Bool {
        return lhs.id == rhs.id
    }
}
