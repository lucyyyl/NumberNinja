//
//  GuessView.swift
//  Wordle
//
//  Created by Lucy Llewellyn on 02/09/2022.
//

import SwiftUI

struct GuessView: View {
    @Binding var guess: Guess
    @State private var buttonBackColor:Color = .systemBackground
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0...3, id: \.self) { index in
                Button {
                    if guess.submitted {
                        switch guess.cardColors[index] {
                            case .systemBackground:
                                guess.cardColors[index] = .red
                            case .red:
                                guess.cardColors[index] = .misplaced
                            case .misplaced:
                                guess.cardColors[index] = .correct
                            default:
                                guess.cardColors[index] = .systemBackground
                        }
                    }
                } label : {
                    Text(guess.guessDigits[index])
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .font(.system(size: 35, weight: .heavy))
                    .border(Color(.secondaryLabel))
                    .background(guess.cardColors[index])
                    .foregroundColor(.primary)
                    
                }
                    
            }
        }
    }
    
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(guess: .constant(Guess(index: 0)))
    }
}
