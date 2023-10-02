//
//  LetterButtonView.swift
//  NumberNinja
//
//  Created by Lucy Llewellyn on 02/09/2022.
//

import SwiftUI

struct DigitButtonView: View {
    @EnvironmentObject var dataModel: NumberNinjaDataModel
    var digit: String

    var body: some View {
        Button {
            dataModel.addToCurrentNumber(digit)
        } label: {
            Text(digit)
                .font(.system(size: 20))
                .frame(width: 40, height: 50)
                .background(dataModel.keyColors[digit])
                .foregroundColor(.primary)
        }
        .buttonStyle(.plain)
    }
}

struct DigitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DigitButtonView(digit: "L")
            .environmentObject(NumberNinjaDataModel())
    }
}
