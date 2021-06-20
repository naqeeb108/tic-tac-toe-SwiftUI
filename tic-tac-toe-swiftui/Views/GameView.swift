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
                            
                            GameIndicators(proxy: geometery, boxColor: "BoxColor")
                            GameCircles(systemImage: viewModel.moves[index]?.indicator ?? "" )
                            
                        } //ZStack
                        .onTapGesture {
                            viewModel.processPlayerMove(for: index)
                        }
                    }
                }
                
                ScoreCounterView(proxy: geometery, humanWinsCount: viewModel.humanWinsCount, ComputerWinsCount: viewModel.ComputerWinsCount)
                
                CustomText(text: "Total Games:  \(viewModel.totalGameCount)", textColor: .black)
                    .padding(.trailing, 20)
                
                CustomText(text: "Draw Games:  \(viewModel.drawGames)", textColor: .black)
                    .padding(.trailing, 20)
                
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
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
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
    var boxColor: String
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(Color(boxColor)).opacity(0.8)
            .cornerRadius(10)
            .shadow(radius: 5)
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

//MARK:- GameIndicators
struct GamesCounterView: View {
    
    var proxy: GeometryProxy
    var boxColor: String
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(Color(boxColor)).opacity(0.8)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.top, 30)
            .frame(width: 150, height: 80)
    }
}

//MARK:- TextView
struct CustomText: View {
    
    var text: String
    var textColor: Color
    
    var body: some View {
        
        Text(text)
            .padding(.all,5)
            .font(.headline)
            .foregroundColor(textColor)
    }
}

//MARK:- ScoreCounterView
struct ScoreCounterView: View {
    
    var proxy: GeometryProxy
    var humanWinsCount: Int
    var ComputerWinsCount: Int
    
    var body: some View {
        
        HStack {
            
            CustomText(text: "You", textColor: .black)
                .padding(.top, 30)
            
            ZStack {
                
                GamesCounterView(proxy: proxy, boxColor: "white")
                
                HStack {
                    CustomText(text: "\(humanWinsCount)", textColor: .black)
                    CustomText(text: "-", textColor: .black)
                    CustomText(text: "\(ComputerWinsCount)", textColor: .black)
                }
                .padding(.top, 30)
            }
            
            CustomText(text: "Comp", textColor: .black)
                .padding(.top, 30)
            
        }
    }
}
