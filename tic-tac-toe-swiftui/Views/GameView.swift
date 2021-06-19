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
                            
                            GameIndicators(proxy: geometery)
                            GameCircles(systemImage: viewModel.moves[index]?.indicator ?? "" )
                            
                        } //ZStack
                        .onTapGesture {
                            viewModel.processPlayerMove(for: index)
                        }
                    }
                }
                
                Spacer()
                
            }
            .padding()
            .disabled(viewModel.isGameBoardDisabled)
            .alert(item: $viewModel.alertItem) { alertItem in
                
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: {
                        viewModel.resetGame()
                      }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

//MARK:- GameIndicators
struct GameIndicators: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        
        Circle()
            .foregroundColor(.red).opacity(0.8)
            .frame(width:  proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}

//MARK:- GameCircles
struct GameCircles: View {
    
    var systemImage: String
    
    var body: some View {
        
        Image(systemName: systemImage)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
        
    }
}
