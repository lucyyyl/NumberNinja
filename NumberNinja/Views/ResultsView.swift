//
//  ResultsView.swift
//  Wordle
//
//  Created by Lucy Llewellyn on 14/04/2023.
//

import SwiftUI

// have 3 boxes
// flip on press of enter
// first one green w number of correct numbers
// second one yellow with number of correct but in wrong place numbers
// third one red with number of incorrect numbers

struct ResultsView: View {
    @Binding var guess: Guess
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0...2, id: \.self) { index in
                FlipView(isFlipped: $guess.cardFlipped[index]) {
                    Text("")
                        .foregroundColor(.primary)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(guess.colors[index])
                } back: {
                    Text("\(guess.result[index])")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(guess.colors[index])
                }
                    .font(.system(size: 35, weight: .heavy))
                    .border(Color(.secondaryLabel))
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(guess: .constant(Guess(index: 0)))
    }
}
