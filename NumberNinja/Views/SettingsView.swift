//
//  SettingsView.swift
//  Wordle
//
//  Created by Lucy Llewellyn on 04/10/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    @EnvironmentObject var dataModel: WordleDataModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                Text("Change Theme")
                Picker("Display Mode", selection: $colorSchemeManager.colorScheme) {
                    Text("Dark").tag(ColorScheme.dark)
                    Text("Light").tag(ColorScheme.light)
                    Text("System").tag(ColorScheme.unspecified)
                }
                .pickerStyle(.segmented)
                Spacer()
            }.padding()
            .navigationTitle("Options")
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

