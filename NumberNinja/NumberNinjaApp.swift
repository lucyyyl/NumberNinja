//
//  NumberNinjaApp.swift
//  NumberNinja
//
//  Created by Lucy Llewellyn on 28/08/2022.
//

import SwiftUI

@main
struct NumberNinjaApp: App {
    @StateObject var dataModel = NumberNinjaDataModel()
    @StateObject var colorSchemeManager = ColorSchemeManager()
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(dataModel)
                .environmentObject(colorSchemeManager)
                .onAppear {
                    colorSchemeManager.applyColorScheme()
                }
        }
    }
}
