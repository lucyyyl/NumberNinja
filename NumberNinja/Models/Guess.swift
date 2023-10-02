//
//  Guess.swift
//  NumberNinja
//
//  Created by Lucy Llewellyn on 02/09/2022.
//

import SwiftUI

struct Guess {
    let index: Int
    var number = "    "
    var bgColors = [Color](repeating: .wrong, count: 4)
    var cardFlipped = [Bool](repeating: false, count: 4)
    var result = [0,0,0]
    var colors = [Color.correct, Color.misplaced, Color.red]
    var guessDigits: [String] {
        number.map { String($0) }
    }
    var cardColors = [Color](repeating: .systemBackground, count: 4)
    var submitted: Bool = false

    var results: String {
        let tryColors: [Color: String] = [.misplaced : "🟨", .correct : "🟩", .wrong : "⬜"]
        return bgColors.compactMap {tryColors[$0]}.joined(separator: "")
    }

}
