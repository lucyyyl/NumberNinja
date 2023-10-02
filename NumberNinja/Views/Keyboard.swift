//
//  Keyboard.swift
//  NumberNinja
//
//  Created by Lucy Llewellyn on 02/09/2022.
//

import SwiftUI

struct Keyboard: View {
    @EnvironmentObject var dataModel: NumberNinjaDataModel
    var topRowArray = "12345".map{ String($0) }
    var secondRowArray = "6789".map{ String($0) }
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(topRowArray, id: \.self) { letter in
                    DigitButtonView(digit: letter)
                }
                .disabled(dataModel.disabledKeys)
                .opacity(dataModel.disabledKeys ? 0.6 : 1)
                Button {
                    dataModel.removeDigitFromCurrentNumber()
                } label: {
                    Image(systemName: "delete.backward.fill")
                        .font(.system(size: 20, weight: .heavy))
                        .frame(width: 40, height: 50)
                        .foregroundColor(.primary)
                        .background(Color.unused)
                        .disabled(dataModel.currentNumber.count == 0 || !dataModel.inPlay)
                        .opacity((dataModel.currentNumber.count == 0 || !dataModel.inPlay) ? 0.6 : 1)

                }
            }
            HStack(spacing: 4) {
                ForEach(secondRowArray, id: \.self) { letter in
                    DigitButtonView(digit: letter)
                }
                .disabled(dataModel.disabledKeys)
                .opacity(dataModel.disabledKeys ? 0.6 : 1)
                Button {
                    dataModel.enterNumber()
                } label: {
                    Text("Enter")
                }
                .font(.system(size: 20))
                .frame(width: 60, height: 50)
                .foregroundColor(.primary)
                .background(Color.unused)
                .disabled(dataModel.currentNumber.count < 4 || !dataModel.inPlay)
                .opacity((dataModel.currentNumber.count < 4 || !dataModel.inPlay) ? 0.6 : 1)

            }
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
            .environmentObject(NumberNinjaDataModel())
            .scaleEffect(Global.keyboardScale)
    }
}
