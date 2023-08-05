//
//  WordleDataModel.swift
//  Wordle
//
//  Created by Lucy Llewellyn on 02/09/2022.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    @Published var guesses: [Guess] = []
    @Published var incorrectAttempts = [Int](repeating: 0, count: 8)
    @Published var toastText: String?
    @Published var showStats = false
    
    var currentStat: Statistic

    var selectedNumber = ""
    var currentNumber = ""
    var toastWords = ["Wow", "Genius", "Magnificent", "Impressive", "Splendid", "Great", "Good", "Phew"]
    var digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var tryIndex = 0
    var inPlay = false
    var gameOver = false
    var keyColors = [String : Color]()

    var gameStarted: Bool {
        !currentNumber.isEmpty || tryIndex > 0
    }

    var disabledKeys: Bool {
        !inPlay || currentNumber.count == 4
    }

    init() {
        currentStat = Statistic.loadStat()
        newGame()
    }

    // MARK: - Setup
    func newGame() {
        populateDefaults()
        selectedNumber = generateNumber(from: digits)
        currentNumber = ""
        inPlay = true
        tryIndex = 0
        gameOver = false
        print(selectedNumber)
    }
    
    func generateNumber(from digits: [String]) -> String {
        let shuffledDigits = digits.shuffled()
        return shuffledDigits[0...3].joined()
    }

    func populateDefaults() {
        guesses = []
        for index in 0...7 {
            guesses.append(Guess(index: index))
        }
        // reset keyboard colors
        let numbers = "123456789"
        for digit in numbers {
            keyColors[String(digit)] = .unused
        }
    }

    // MARK: - Game Play
    func addToCurrentNumber(_ digit: String) {
        if !currentNumber.contains(digit) {
            currentNumber += digit
            updateRow()
        } else {
            showToast(with: "Oops! You've already used this digit in your guess.")
        }

    }

    func enterWord() {
        if currentNumber == selectedNumber {
            gameOver = true
            calculateResults()
            currentStat.update(win: true, index: tryIndex)
            showToast(with: toastWords[tryIndex])
            inPlay = false
        } else {
            calculateResults()
            guesses[tryIndex].submitted = true
            tryIndex += 1
            currentNumber = ""
            if tryIndex == 8 {
                gameOver = true
                inPlay = false
                currentStat.update(win: false)
                showToast(with: "It was: \(selectedNumber)")
            }
        }
    }

    func removeDigitFromCurrentNumber() {
        if currentNumber.count > 0 {
            currentNumber.removeLast()
            updateRow()
        }
    }

    func updateRow() {
        let guessWord = currentNumber.padding(toLength: 4, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessWord
    }

    func calculateResults() {
        let correctDigits = selectedNumber.map { String($0) }
        var correctTotal = 0
        var misplacedTotal = 0
        var incorrectTotal = 0

        for index in 0...3 {
            let correctDigit = correctDigits[index]
            let guessDigit = guesses[tryIndex].guessDigits[index]
            if guessDigit == correctDigit {
                correctTotal += 1
            } else if correctDigits.contains(guessDigit) {
                misplacedTotal += 1
            } else {
                incorrectTotal += 1
            }
            keyColors[guessDigit] = .wrong
        }

        guesses[tryIndex].result[0] = correctTotal
        guesses[tryIndex].result[1] = misplacedTotal
        guesses[tryIndex].result[2] = incorrectTotal

        flipCards(for: tryIndex)
    }

    func flipCards(for row: Int) {
        for col in 0...3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(col) * 0.2) {
                self.guesses[row].cardFlipped[col].toggle()
                if self.gameOver && self.tryIndex < 8 {
                    self.guesses[self.tryIndex].cardColors = [.correct, .correct, .correct, .correct]
                }
            }
        }
    }

    func showToast(with text: String?) {
        withAnimation {
            toastText = text
        }
        withAnimation(Animation.linear(duration: 0.2).delay(3)) {
            toastText = nil
            if gameOver {
                let seconds = 3.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.showStats.toggle()
                }
            }
        }
    }

    func shareResult() {
        let stat = Statistic.loadStat()
        let results = guesses.enumerated().compactMap { $0 }
        var guessString = ""
        for result in results {
            if result.0 <= tryIndex {
                guessString += result.1.results + "\n"
            }
        }
        let resultsString = """
NumberNinja \(stat.games) \(tryIndex < 8 ? "\(tryIndex + 1)/8" : "")
\(guessString)
"""
        let activityController = UIActivityViewController(activityItems: [resultsString], applicationActivities: nil)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            UIWindow.key?.rootViewController!
                .present(activityController, animated: true)
        case .pad:
            activityController.popoverPresentationController?.sourceView = UIWindow.key
            activityController.popoverPresentationController?.sourceRect = CGRect(x: Global.screenWidth / 2, y: Global.screenHeight / 2, width: 200, height: 200)
            UIWindow.key?.rootViewController!.present(activityController, animated: true)
        default:
            break
        }
    }
}
