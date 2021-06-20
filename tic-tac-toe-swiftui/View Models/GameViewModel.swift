//
//  GameViewModel.swift
//  tic-tac-toe-swiftui
//
//  Created by Mac on 19/06/2021.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    
    //MARK:- variables
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem: alertItem?
    @Published var humanWinsCount = 0
    @Published var ComputerWinsCount = 0
    @Published var totalGameCount = 0
    @Published var drawGames = 0
    
    
    //MARK:- processPlayerMove
    func processPlayerMove(for Position: Int) {
        
        if isCircleOccupied(in: moves, forIndex: Position) { return }
        moves[Position] = Move(player: .human, boradIndex: Position)
        
        //check for win condition
        if checkWinCondition(for: .human, in: moves) {
            humanWinsCount += 1
            totalGameCount += 1
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            drawGames += 1
            totalGameCount += 1
            alertItem = AlertContext.matchDraw
            return
        }
        
        isGameBoardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boradIndex: computerPosition)
            isGameBoardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                ComputerWinsCount += 1
                totalGameCount += 1
                alertItem = AlertContext.computerWin
                return
                
            }
            
            if checkForDraw(in: moves) {
                drawGames += 1
                totalGameCount += 1
                alertItem = AlertContext.matchDraw
                return
                
            }
        }
    }
    
    
    //MARK:- determineComputerMovePosition
    func determineComputerMovePosition(in move: [Move?]) -> Int {
        
        let winPatterns: Set<Set<Int>> = [ [0,1,2],
                                           [3,4,5],
                                           [6,7,8],
                                           [0,3,6],
                                           [1,4,7],
                                           [2,5,8],
                                           [0,4,8],
                                           [2,4,6]
        ]
        
        //move smartly on avaiable postion
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boradIndex })
        
        for pattern in winPatterns {
            
            let winPosition = pattern.subtracting(computerPositions)
            
            if winPosition.count == 1 {
                
                let isPositionAvailable = !isCircleOccupied(in: moves, forIndex: winPosition.first!)
                if isPositionAvailable { return winPosition.first! }
                
            }
        }
        
        //move smartly and block human from winning battle
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPositions = Set(humanMoves.map { $0.boradIndex })
        
        for pattern in winPatterns {
            
            let winPosition = pattern.subtracting(humanPositions)
            
            if winPosition.count == 1 {
                
                let isPositionAvailable = !isCircleOccupied(in: moves, forIndex: winPosition.first!)
                if isPositionAvailable { return winPosition.first! }
                
            }
        }
        
        //place move in middle postion
        let centerCircle = 4
        if !isCircleOccupied(in: move, forIndex: centerCircle) { return centerCircle }
        
        var movePosintion = Int.random(in: 0..<9)
        
        while isCircleOccupied(in: moves, forIndex: movePosintion) {
            
            movePosintion = Int.random(in: 0..<9)
        }
        
        return movePosintion
    }
    
    //MARK:- checkWinCondition
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        
        let winPatterns: Set<Set<Int>> = [ [0,1,2],
                                           [3,4,5],
                                           [6,7,8],
                                           [0,3,6],
                                           [1,4,7],
                                           [2,5,8],
                                           [0,4,8],
                                           [2,4,6]
        ]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boradIndex })
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    //MARK:- checkForDraw
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
        
    }
    
    //MARK:- resetGame
    func resetGame() {
        
        moves =  Array(repeating: nil, count: 9)
        
    }
    
    //MARK:- isCircleOccupied
    func isCircleOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boradIndex == index } )
        
    }
    
}
