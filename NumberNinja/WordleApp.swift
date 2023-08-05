//
//  WordleApp.swift
//  Wordle
//
//  Created by Lucy Llewellyn on 28/08/2022.
//

import SwiftUI

@main
struct WordleApp: App {
    @StateObject var dataModel = WordleDataModel()
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
