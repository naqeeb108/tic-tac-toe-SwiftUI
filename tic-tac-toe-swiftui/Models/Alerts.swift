//
//  Alerts.swift
//  tic-tac-toe-swiftui
//
//  Created by Mac on 19/06/2021.
//

import Foundation
import SwiftUI

struct alertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    
    static let humanWin = alertItem(title: Text("You win...!!!"),
                                    message: Text(""),
                                    buttonTitle: Text("Play Again"))
    
    static let computerWin = alertItem(title: Text("You Lose...!!!"),
                                       message: Text(""),
                                       buttonTitle: Text("Play Again"))
    
    static let matchDraw = alertItem(title: Text("Match Draw...!!!"),
                                     message: Text(""),
                                     buttonTitle: Text("Try Again"))
}
