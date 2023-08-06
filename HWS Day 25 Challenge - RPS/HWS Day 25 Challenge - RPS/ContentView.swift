//
//  ContentView.swift
//  HWS Day 25 Challenge - RPS
//
//  Created by Aaron Burbach on 8/6/23.
//

import SwiftUI

struct ContentView: View {
    enum PossibleMoves: String, CaseIterable {
        case rock = "🪨"
        case paper = "📄"
        case scissors = "✂️"
    }
    
    enum PossibleOutcomes: String, CaseIterable {
        case win = "✅"
        case lose = "❌"
    }
    
    
    @State private var possibleMovesList: [PossibleMoves] = PossibleMoves.allCases.shuffled()
    @State private var possibleOutcomesList: [PossibleOutcomes] = PossibleOutcomes.allCases.shuffled()
    
    @State private var computerSelectedMove = PossibleMoves.allCases.shuffled()[Int.random(in: 0...2)]
    @State private var computerSelectedOutcome = PossibleOutcomes.allCases.shuffled()[Int.random(in: 0...1)]
    @State private var showingGameComplete = false
    @State private var totalRoundsPlayed = 0
    @State private var playerScore = 0
    
    var body: some View {
        VStack {
            Group {
                Spacer()
                Spacer()
                
                Text("Computer's selection: \(computerSelectedMove.rawValue)")
                    .font(.title)
                
                Spacer()
                
                Text("Player should try to \(computerSelectedOutcome.rawValue) the game.")
                    .font(.title2)
                
                Spacer()
            }
            
            HStack {
                Button {
                    scoreRound(with: PossibleMoves.rock)
                } label: {
                    Text(PossibleMoves.rock.rawValue)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                
                Button {
                    scoreRound(with: PossibleMoves.paper)
                } label: {
                    Text(PossibleMoves.paper.rawValue)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                
                Button {
                    scoreRound(with: PossibleMoves.scissors)
                } label: {
                    Text(PossibleMoves.scissors.rawValue)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                
            }
            
            Spacer()
            
            Text("Player's score: \(playerScore)")
                .font(.largeTitle)
            
            Spacer()
            Spacer()
        }
        .alert("Game Over", isPresented: $showingGameComplete) {
            Button("Continue", action: resetGame)
        } message: {
            Text("Game over. Your score is \(playerScore)!")
        }
    }
        
    func scoreRound(with playerMove: PossibleMoves) {        
        // increment the number of rounds played
        totalRoundsPlayed += 1
        
        // check the player's move vs the computer-generated outcome and move and score the round
        if (computerSelectedOutcome == .win) {
            switch computerSelectedMove {
            case .rock:
                if (playerMove == .paper) { addOneToScore() } else { deductOneFromScore()}
            case .paper:
                if (playerMove == .scissors) { addOneToScore() } else { deductOneFromScore()}
            case .scissors:
                if (playerMove == .rock) { addOneToScore() } else { deductOneFromScore()}
            }
        } else {
            switch computerSelectedMove {
            case .rock:
                if (playerMove == .scissors) { addOneToScore() } else { deductOneFromScore()}
            case .paper:
                if (playerMove == .rock) { addOneToScore() } else { deductOneFromScore()}
            case .scissors:
                if (playerMove == .paper) { addOneToScore() } else { deductOneFromScore()}
            }
        }

        // check for game over
        if (totalRoundsPlayed == 10) {
            showingGameComplete = true
            return
        } else {
            newRound()
        }
    }
    
    func resetGame() {
        showingGameComplete = false
        playerScore = 0
        totalRoundsPlayed = 0
        newRound()
    }
    
    func newRound() {
        possibleMovesList.shuffle()
        possibleOutcomesList.shuffle()
        computerSelectedMove = PossibleMoves.allCases.shuffled()[Int.random(in: 0...2)]
        computerSelectedOutcome = PossibleOutcomes.allCases.shuffled()[Int.random(in: 0...1)]
    }
    
    func addOneToScore() {
        playerScore += 1
    }
    
    func deductOneFromScore() {
        playerScore -= 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
