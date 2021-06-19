//
//  GameView.swift
//  tic-tac-toe-swiftui
//
//  Created by Mac on 19/06/2021.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        
        GeometryReader { geometery in
            
            VStack {
                
                Spacer()
                
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    
                    ForEach(0..<9) { index in
                        
                        ZStack {
                            
                            Circle()
                                .foregroundColor(.red).opacity(0.8)
                                .frame(width: geometery.size.width/3 - 15,
                                       height: geometery.size.width/3 - 15)
                            
                            Image(systemName: viewModel.moves[index]?.indicator ?? "" )
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                            
                        } //ZStack
                        .onTapGesture {
                            viewModel.processPlayerMove(for: index)
                        }
                    }
                }
                
                Spacer()
                
            } //VStack
            .padding()
            .disabled(viewModel.isGameBoardDisabled)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: {
                        viewModel.resetGame()
                      }))
            }
            
        } //GeometryReader
        
    }
}

enum Player {
    case human, computer
}

struct Move {
    
    let player: Player
    let boradIndex: Int
    
    var indicator : String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
