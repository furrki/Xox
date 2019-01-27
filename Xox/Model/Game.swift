//
//  Game.swift
//  Xox
//
//  Created by Admin on 27.01.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation

class Game {
    static var shared = Game()
    
    var situation: GameSituation = .playerTurn
    
    let playerSign = "X"
    let opSign = "O"
    var ai: AI!
    
    var table: [SquareType] = []
    
    init() {
        if Bool.random() {
            situation = .opTurn
        }
        for _ in 1...9 {
            table.append(.empty)
        }
        
        ai = AI(game: self)
    }
    
    func doMove(at index: Int, who player: PlayerType) {
        let cell = table[index]
        if cell == .empty {
            table[index] = player.square
        }
    }
    
    
}

enum PlayerType {
    case player, op
}
extension PlayerType {
    var sign: String {
        switch self {
        case .player:
            return "X"
        case .op:
            return "O"
        }
    }
    var square: SquareType {
        switch self {
        case .player:
            return .player
        case .op:
            return .op
        }
    }
}

enum SquareType {
    case player, op, empty
}

enum GameSituation {
    case playerTurn, opTurn, final
}

protocol GameDelegate {
    func game(contents: [Bool])
}

