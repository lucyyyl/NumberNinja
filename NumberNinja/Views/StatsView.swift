//
//  StatsView.swift
//  NumberNinja
//
//  Created by Lucy Llewellyn on 30/09/2022.
//

import SwiftUI
import Charts

struct StatsView: View {
    @EnvironmentObject var dataModel: NumberNinjaDataModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            
            VStack(spacing: 10) {
                //            HStack {
                //                Spacer()
                //                Button {
                //                    withAnimation {
                //                        dataModel.showStats.toggle()
                //                    }
                //                } label: {
                //                    Text("X")
                //                }
                //                .offset(x: 20, y: 10)
                //            }
                Text("STATISTICS")
                    .font(.title2)
                    .fontWeight(.bold)
                HStack(alignment: .top) {
                    Spacer()
                    SingleStat(value: dataModel.currentStat.games, text: "Played")
                    Spacer()
                    if dataModel.currentStat.games != 0 {
                        SingleStat(value: Int(100 * dataModel.currentStat.wins/dataModel.currentStat.games), text: "Win %")
                        Spacer()
                    }
                    SingleStat(value: dataModel.currentStat.streak, text: "Current Streak")
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    SingleStat(value: dataModel.currentStat.maxStreak, text: "Max Streak")
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                Spacer()
                Text("GUESS DISTRIBUTION")
                    .font(.title2)
                    .fontWeight(.bold)
                VStack(spacing: 5) {
                    Chart{
                        ForEach (0..<8, id: \.self) { index in
                            BarMark(
                                x: .value("Guesses", "\(index+1)"),
                                y: .value("Frequency", dataModel.currentStat.frequencies[index])
                            )
                            .foregroundStyle(.mint)
                            .cornerRadius(10)
                            .annotation(position: .top) {
                                let number = dataModel.currentStat.frequencies[index]
                                if number != 0 {
                                    Text("\(number)")
                                        .font(.caption)
                                } else {
                                    Text("")
                                }
                            }
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: 8)) {
                            mark in
                            AxisValueLabel()
                        }
                    }
                    .chartXAxisLabel("Number of Guesses")
//                    .chartXAxis(content: {
//                        AxisMarks {_ in
//                            AxisGridLine(
//                                centered: true,
//                                stroke: StrokeStyle(
//                                    dash: [2, 4, 8]))
//                                  .foregroundStyle(Color.red)
//                        }
//                    })
                    .chartYAxis {
                        AxisMarks(position: .leading) {
                            mark in
                            AxisValueLabel()
                            AxisGridLine(
                                centered: true, stroke: StrokeStyle(dash: [4,4]))
                        }
                    }
                    .chartYAxisLabel("Frequency", position: .leading)
                    .padding([.top, .bottom], 30)
                    .padding([.leading, .trailing], 15)
                    if dataModel.gameOver {
                        Button {
                            dataModel.newGame()
                            dismiss()
                        } label: {
                            Text("New game")
                                .foregroundColor(Color.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
//                    .background(.gray.opacity(0.1))
//                    .cornerRadius(8.0)

//                    if dataModel.gameOver {
//                        HStack {
//                            Spacer()
//                            Button {
//                                dataModel.shareResult()
//                            } label: {
//                                HStack {
//                                    Image(systemName: "square.and.arrow.up")
//                                    Text("Share")
//                                }
//                                .foregroundColor(.white)
//                                .padding(8)
//                                .background(Color.correct)
//                            }
//                        }
//                    }
                }
                Spacer()
            }
            //        .padding(.horizontal, 40)
            .frame(width: min(Global.screenWidth - 40, 350))
//            .navigationTitle("STATISTICS")
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
            //        .background(RoundedRectangle(cornerRadius: 15)
            //            .fill(Color.systemBackground))
            //        .padding()
            //        .shadow(color: .black.opacity(0.3), radius: 10)
            //        .offset(y: -70)
        }
    }
}

struct SingleStat: View {
    let value: Int
    let text: String
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.largeTitle)
            Text(text)
                .font(.caption)
                .frame(width: 50)
                .multilineTextAlignment(.center)
        }
    }
}
