//
//  ContentView.swift
//  Wordle
//
//  Created by Lucy Llewellyn on 28/08/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dataModel: WordleDataModel
    @State private var showSettings = false
    @State private var showHelp = false
//    @ObservedObject var showStats
    var body: some View {
        ZStack {
            NavigationView {
                    VStack {
                        Spacer()
                        HStack {
                            VStack(spacing: 3){
                                ForEach(0...7, id: \.self) { index in
                                    GuessView(guess: $dataModel.guesses[index]).modifier(Shake(animatableData: CGFloat(dataModel.incorrectAttempts[index])))
                                }
                            }
                            VStack(spacing: 3){
                                ForEach(0...7, id: \.self) { index in
                                    ResultsView(guess: $dataModel.guesses[index]).modifier(Shake(animatableData: CGFloat(dataModel.incorrectAttempts[index])))
                                }
                            }
                        }

                        .frame(width: Global.boardWidth, height: 6 * Global.boardWidth / 5)
                        Spacer()
                        Keyboard()
                            .scaleEffect(Global.keyboardScale)
                            .padding(.top)
                        Spacer()
                    }
                .navigationBarTitleDisplayMode(.inline)
//                .disabled(dataModel.showStats)
                .overlay(alignment: .top) {
                    if let toastText = dataModel.toastText {
                        ToastView(toastText: toastText)
                            .offset(y: 20)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            if !dataModel.inPlay {
                                Button {
                                    dataModel.newGame()
                                } label: {
                                    Text("New")
                                        .foregroundColor(Color.white)
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.green)
                            }
                            Button {
                                showHelp.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle")
                            }
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("NumberNinja")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                            .minimumScaleFactor(0.5)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                withAnimation {
                                    dataModel.showStats.toggle()
//                                showStats.toggle()
                                }
                            } label: {
                                Image(systemName: "chart.bar")
                            }
                            Button {
                                showSettings.toggle()
                            } label: {
                                Image(systemName: "gearshape.fill")
                            }
                        }
                    }
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
            }
            .sheet(isPresented: self.$dataModel.showStats) {
                StatsView()
            }
        }
//        .navigationViewStyle(.stack)
        .sheet(isPresented: $showHelp) {
            HelpView()
        }

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(WordleDataModel())
    }
}
