//
//  TicTacToe.swift
//  Visionary Tic Tac Toe
//
//  Created by Tilak Shakya on 14/02/24.
//

import SwiftUI

struct TicTacToe: View {
    @StateObject var gameState = GameState()
    @State private var isGameActive = false
    @State private var isSoundPlaying = false
    
    let gridSize: CGFloat = 3
    let cellSize: CGFloat = 100
    let borderSize: CGFloat = 5
    
    var body: some View {
        VStack {
            Text(gameState.turnText())
                .font(.title)
                .bold()
                .padding()
            
            Spacer()
            
            Text(String(format: "Crosses: %d", gameState.crossesScore))
                .font(.title)
                .bold()
                .padding()
            
            VStack(spacing: borderSize) {
                ForEach(0..<Int(gridSize)) { row in
                    HStack(spacing: borderSize) {
                        ForEach(0..<Int(gridSize)) { column in
                            let cell = gameState.board[row][column]
                            
                            Text(cell.displayTile())
                                .font(.system(size: 60))
                                .foregroundColor(cell.tileColor())
                                .bold()
                                .frame(width: cellSize, height: cellSize)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6509803922, green: 0.8235294118, blue: 0.9882352941, alpha: 1)), Color(#colorLiteral(red: 0.8901960784, green: 0.9568627451, blue: 0.9882352941, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                                .onTapGesture {
                                    gameState.placeTile(row, column)
                                    playSoundForTile(cell)
                                    isGameActive = false
                                    isSoundPlaying = false // Reset sound state when a new move is made
                                }
                        }
                    }
                }
            }
            .background(Color.black)
            .padding()
            .alert(isPresented: $gameState.showAlert) {
                let message = gameState.alertMessage
                return Alert(
                    title: Text(message),
                    dismissButton: .default(Text("Okay")) {
                        gameState.resetBoard()
                        isGameActive = true
                        isSoundPlaying = false // Reset sound state when the game is reset
                    }
                )
            }
            
            Text(String(format: "Noughts: %d", gameState.noughtsScore))
                .font(.title)
                .bold()
                .padding()
            
            Spacer()
        }
        .onAppear {
            isGameActive = gameState.turn == .Cross
        }
        .onChange(of: gameState.showAlert) { showAlert in
            if showAlert {
                isSoundPlaying = false
                SoundManager.shared.stopSound()
            }
        }
    }
    
    private func playSoundForTile(_ cell: Cell) {
        if !isSoundPlaying {
            isSoundPlaying = true
            if cell.tile == .Cross {
                SoundManager.shared.playSound(named: "newXSound", ofType: "mp3")
            } else {
                SoundManager.shared.playSound(named: "newOSound", ofType: "mp3")
            }
        }
    }
}



#Preview {
    TicTacToe()
}
