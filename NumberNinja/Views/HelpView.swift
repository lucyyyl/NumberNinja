//
//  HelpView.swift
//  NumberNinja
//
//  Created by Lucy Llewellyn on 06/10/2022.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    Text(
    """
    Guess the **NUMBER** in 8 tries.

    Each guess must be a 4 digit number, no digit is repeated. Hit the enter button to submit.

    After each guess, the colored tiles will flip showing how close your guess was to the number.
    """
                    )
                    Divider()
                    Text("**Example**")
                    VStack(alignment: .leading) {
                        Image("firstGuess")
                            .resizable()
                            .scaledToFit()
                        Text("**1** digit is in the number and in the correct place, **2** digits are in the number but in the wrong place & **1** digit is not in the number at all.")
                        Image("secondGuess")
                            .resizable()
                            .scaledToFit()
                        Text("**0** digits are in the correct place, **3** digits are in the number but in the wrong place & **1** digit is no in the number at all.")
                        Image("thirdGuess")
                            .resizable()
                            .scaledToFit()
                        Text("All digits are in the correct place 🥳")
                    }
                    VStack(alignment: .center) {
                        Divider()
                        Text("**Top Tip**")
                        Spacer()
                        Text("Tip: You can change the colour of the tiles of your guesses by tapping on the tiles after you’ve entered your guess.")
                        Image("colorChanged")
                            .resizable()
                            .scaledToFit()
                        Divider()
                        Text("**Tap the NEW button for a new NUMBER.**")
                        Spacer()
                    }
                }
            }
            .frame(width: min(Global.screenWidth - 40, 350))
            .navigationTitle("HOW TO PLAY")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
        }
    }
}

