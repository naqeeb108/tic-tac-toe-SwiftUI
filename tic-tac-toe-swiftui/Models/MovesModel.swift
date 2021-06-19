//
//  MovesModel.swift
//  tic-tac-toe-swiftui
//
//  Created by Mac on 19/06/2021.
//

import Foundation


struct Move {
    
    let player: Player
    let boradIndex: Int
    
    var indicator : String {
        return player == .human ? "xmark" : "circle"
    }
}
