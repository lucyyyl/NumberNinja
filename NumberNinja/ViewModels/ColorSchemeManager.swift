//
//  ColorSchemeManager.swift
//  NumberNinja
//
//  Created by Lucy Llewellyn on 04/10/2022.
//

import SwiftUI

enum ColorScheme: Int {
    case unspecified, light, dark
}

class ColorSchemeManager: ObservableObject {
    @AppStorage("colorScheme") var colorScheme: ColorScheme = .unspecified {
        didSet {
            applyColorScheme()
        }
    }

    func applyColorScheme() {
        UIWindow.key?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue:  colorScheme.rawValue)!
    }
}
